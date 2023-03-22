// Simulation NED file
//

//

package csma_ca;

// Sensor node
simple SensorNodeCSMACA
{
    
    parameters:
        //each packet is transmitted every T = 5s. 
        int T_value @unit(s) = default(5.0s);
        //
        double Tcca_value @unit(s) = default(0.000128s);
        //the backoff period is set to 32ms
        double Dbp_value @unit(s) = default(0.00032s);
        //the backoff exponent 
        int macMinBE_value @prompt("macMinBE") = default(3);
        int macMaxBE_value @prompt("macMaxBE") = default(4);
        int macMaxCSMABackoffs_value @prompt("macMaxCSMABackoffs") = default(2);
        double Dp_value @unit(s) = default(0.004256s);
        //every node transmit 1000 packets
        int pkt_to_send_value = default(1000);
        //TX and RX power value
        double ptx_value @unit(W) = default(0.0495W);
        double prx_value @unit(W) = default(0.0564W);
        @display("i=block/source");
        //Class name 
        @class(csma_ca::SensorNodeCSMACA);
    gates:
        output out;
}

// Sink
simple SinkNodeCSMACA 
{
    
    parameters:
        @display("i=block/sink");
        @class(csma_ca::SinkNodeCSMACA);
    gates:
        input in[];
}

// Network
network SourceSink
{
    parameters:
        int n @prompt("Number of Nodes") = default(5);
        bool channel_free = default(true);
        int concurrent_tx = default(0);
        double latency = default(0);
        double dropped_pkts = default(0);
        int tx_pkts = default(0);
        double energy = default(0);
    submodules:
        source[n]: SensorNodeCSMACA {
        }
        sink: SinkNodeCSMACA {
        }
    connections:
        for i=0..n-1 {
            source[i].out --> sink.in++;
        }
}
