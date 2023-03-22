/* SinkNodeCSMACA
 *

 */

#include <omnetpp.h>
#include <math.h>
#include "sink.h"

using namespace omnetpp;
Define_Module(csma_ca::SinkNodeCSMACA);
namespace csma_ca {
//module named SinkNodeCSMACA
void SinkNodeCSMACA::initialize()
{
    // initialize
    received_pkts = 0;
    collided = 0;
}

void SinkNodeCSMACA::handleMessage(cMessage *msg)
{
    cModule* c = getModuleByPath("SourceSink");

    // checking for collision first
    if (((int) c->par("concurrent_tx")) > 1)
    {
        EV << "Collision" << endl;

        // increment in collided counter of packets
        collided++;
    }
    else    // successfully transmitted
    {
        EV << "Packet successfully received" << endl;

        // increment in successfully transmitted packets counter
        received_pkts++;
    }

    cancelAndDelete(msg);
}
//result values printing
void SinkNodeCSMACA::finish()
{
    cModule* c = getModuleByPath("SourceSink");

    double tot_p = received_pkts + collided + ((double) c->par("dropped_pkts"));

    // Final result printing
    EV << "Average Delivery Ratio (DR): " << ((double) received_pkts) / tot_p * 100. << "%" << endl;
    EV << "Average Latency (L): " << ((double) c->par("latency"))  / ((double) received_pkts) * 1000. << "ms" << endl;
    EV << "Average Energy Consumption (E): " << ((double) c->par("energy")) / ((double) received_pkts) * 1000. << "mJ" << endl;
}

}; // namespace


