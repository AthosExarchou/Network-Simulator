set ns [new Simulator]

set f [open out.tr w]

set nf [open out.nam w]
$ns namtrace-all $nf

proc finish {} {
	global ns nf
	global f
	$ns flush-trace
	close $nf
	close $f
	exit 0
}

proc record {} {
global sink f
set ns [Simulator instance]
 #Ορισμός της ώρας που η διαδικασία θα ξανακληθεί.
set time 0.2
 #Καταγραφή των bytes.
set bw [$sink set bytes_]
 #Λήψη της τρέχουσας ώρας
set now [$ns now]
 #Υπολογισμός του bandwidth και καταγραφή αυτού στο αρχείο
puts $f "$now [expr (($bw/$time)*8)/1000000]"
 #Κάνει την τιμή bytes_ 0
$sink set bytes_ 0
 #Επαναπρογραμματισμός της διαδικασίας
$ns at [expr $now+$time] "record"
}

#Δημιουργία αντηκειμένων δύο κόμβων που αντιστοιχούνται στα handles n0 και n1 
set n0 [$ns node]
set n1 [$ns node]

#σύνδεση των δύο κόμβων
$ns duplex-link $n0 $n1 1Mb 10ms DropTail

#Δημιουργία ενός UDP agent και «προσάρτησή» του στον κόμβο «n0»
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

#Δημιουργία μιας πηγής κίνησης CBR και «τοποθέτησή» της στο «udp0»
set cbr0 [new Application/Traffic/CBR]

#Προσδιορισμός της κίνησης για τον κόμβο n0
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set sink [new Agent/LossMonitor]
$ns attach-agent $n1 $sink

$ns connect $udp0 $sink

$ns at 0.0 "record"
$ns at 4.0 "$cbr0 start"
$ns at 4.1 "$cbr0 stop"

$ns at 5.0 "finish"
$ns run
