# Network Simulator 2 (NS-2): Network Performance Analysis

This repository contains the source code, configuration files, and simulation reports for two exercises completed using Network Simulator 2 (NS-2) for the
**Computer Networks** course at [Harokopio University of Athens – Dept. of Informatics and Telematics](https://www.dit.hua.gr).\
The exercises explore fundamental networking concepts such as data transmission rates, channel utilization, packet loss, and the behavior of different queuing mechanisms.

## Project Structure

The project is organized into two main directories, one for each exercise, along with the final reports:

```text
network-simulator/
├── exercise1/
│   ├── exercise1.tcl        # TCL script for the simple two-node network
│   └── out.tr               # Trace file showing bandwidth over time (used for Xgraph)
├── exercise2/
│   ├── exercise2.tcl        # TCL script for the multi-flow, queuing discipline network
│   ├── out.nam              # Network Animator file for visual simulation of packet flow/loss
│   ├── out0.tr              # Trace file for Flow 0 (Blue) bandwidth (used for Xgraph)
│   └── out1.tr              # Trace file for Flow 1 (Red) bandwidth (used for Xgraph)
├── exercise1_report_el.pdf  # Detailed report and analysis for Exercise 1
├── exercise2_report_el.pdf  # Detailed report and analysis for Exercise 2
└── README.md                # Project documentation, setup instructions, and key findings summary
```

## Exercise 1: Simple Two-Node Network Analysis

This exercise simulates a basic network with two nodes (node 0 → node 1) to analyze key performance metrics under Constant Bit Rate (CBR) traffic.

### Network Configuration (node 0 → node 1)

- **Link Capacity**: 1 Mbps
- **Propagation Delay**: 10 ms
- **Queuing Discipline**: DropTail
- **Packet Size**: 500 bytes 
- **CBR Interval**: 0.005 seconds

### Key Findings and Metrics

The simulation parameters yielded the following results:

| Metric                                | Value           | Reference                                                      |
|---------------------------------------|-----------------|----------------------------------------------------------------|
| **Gross Transmission Rate**           | 800,000 bit/sec | Calculated as (500 bytes * 8 bits/byte)/0.005 sec              |
| **Channel Utilization**               | 50%             | Reflecting the transfer of 500B packets from node 0 to node 1. |
| **Link Capacity (in bytes)**          | 1000 bytes      | Total bytes on the link at any moment.                         |
| **Net Data Rate (Excluding Headers)** | 736,000 bit/sec | Assuming a 40 byte IP/UDP header.                              |

## Exercise 2: Multi-Flow Queuing Analysis

This exercise models a more complex network with two competing CBR data flows (Blue from 0 → 3 and Red from 1 → 3) sharing a bottleneck link (node 2 → node 3), primarily to compare DropTail and SFQ queuing.

### Network Topology and Link Configuration

- **Nodes**: 0, 1, 2, 3
- **Access Links** (0 → 2, 1 → 2): 1 Mb, 10 ms delay, **DropTail** queue
- **Bottleneck Link** (2 → 3): 1 Mb, 10 ms delay, **SFQ** queue (or DropTail for comparative test)

### Queuing Discipline Comparison (Throughput in Mb/sec)

The analysis focused on the rate of data transfer for each flow (`out0.tr` for Flow 0/Blue, `out1.tr` for Flow 1/Red) using **Xgraph** plots.

| Queuing Discipline | Flow             | Max Throughput | Min Throughput |
|--------------------|------------------|----------------|----------------|
| **DropTail**       | Blue (`out0.tr`) | 1.0 Mb/sec     | 0.2 Mb/sec     |
| **DropTail**       | Red (`out1.tr`)  | 0.82 Mb/sec    | 0.42 Mb/sec    |
| **SFQ**            | Blue (`out0.tr`) | 0.94 Mb/sec    | 0.5 Mb/sec     |
| **SFQ**            | Red (`out1.tr`)  | 0.5 Mb/sec     | 0.43 Mb/sec    |

### Packet Loss Analysis

The numerical analysis for an intermediate simulation (presumably with DropTail on the bottleneck) showed significant differences in packet loss between the two flows, highlighting the unfairness of the DropTail queue:

- **Total Blue Packets**: 800 
- **Lost Blue Packets**: 403 
- **Blue Loss Percentage**: ≈50.4% 
- **Red Loss Percentage**: 0% 

## How to Run the Simulations

To run these simulations, you must have **NS-2** installed on your system.

1. Clone the repository: 
    ```bash
    git clone https://github.com/AthosExarchou/network-simulator.git
    cd network-simulator
    ```

2. Run Exercise 1:
    ```bash
    cd exercise1
    ns exercise1.tcl
    # Use xgraph out.tr to visualize the bandwidth trace
    ```

3. Run Exercise 1:
    ```bash
    cd exercise2
    ns exercise2.tcl
    # Visualize the animation
    nam out.nam
    # Use xgraph out0.tr out1.tr to visualize the bandwidth traces
    ```

## Author

- **Name**: Exarchou Athos
- **Student ID**: it2022134
- **Email**: athosexarhou@gmail.com

## License

This project is licensed under the **MIT License**.
