# Internet-of-Things-Network-Simulation
Developed an algorithm using Eclipse-based OMNeT++ network simulator to evaluate the performance unslotted (CSMA/CA) scheme used by well-known IEEE 802.15.4 standard (Zigbee).

Background:
	The IEEE 802.15.4 standard addresses the physical and medium access control (MAC) layers of the networking stack and is complemented by the ZigBee specifications, which cover higher layers (i.e., network and application layers). The standard defines a Beacon-Enabled (BE) mode and a Non-Beacon-Enabled (NBE) mode. The BE mode relies on a periodic superframe bounded by beacons, which are special synchronization frames generated by coordinator nodes. In the NBE mode, on the other hand, nodes do not use beacons and use an unslotted CSMA/CA algorithm for frame transmissions. Provided below is a short description of the CSMA/CA algorithm used by sensor nodes to transmit data to their coordinator node.

Algorithm: 
	Upon receiving a data frame to be transmitted, the MAC layer at the sensor node performs the following steps.
1. A set of state variables is initialized, namely the number of backoff stages carried out for the on-going transmission (NB = 0) and the backoff exponent (BE = macMinBE).
2. A random backoff time is generated and used to initialize a timer. The backoff time is obtained by multiplying an integer number uniformly distributed in [0, 2BE−1] by the the duration of the backoff period (Dbp). As soon as the timer expires the algorithm
moves to step 3.
3. A Clear Channel Assessment (CCA) is performed to check the state of the wireless medium.
	(a) If the medium is free (i.e., the channel is perceived as free for TCCA time, the packet is transmitted after Dbp − TCCA time.
	(b) If the medium is busy, state variables are updated as follows: NB = NB+1 and BE = min(BE+1,macMaxBE). If the number of backoff stages has exceeded the maximum 					allowed value (i.e. NB > macMaxCSMABackoffs), the frame is 1 dropped. The new backoff time is extracted after Dbp − TCCA time. Otherwise, the algorithm falls back 				to step 2.
In this Project, we will focus on evaluating the performance of the unslotted CSMA/CA
scheme in perfect channel conditions.

Task 1:
	Implemented a module named SensorNodeCSMACA that uses the unslotted CSMA/CA schemeof the NBE IEEE 802.15.4 summarized in the previous section to access the physical channeland transmit a data packet. In order to test your module, I implemented a SinkNodeCSMACAmodule that is connected to a SensorNodeCSMACA node and collects its data. For the sake of simplicity, I assumed that if the node finds the channel free at a particular time, the CCA is passed (i.e., TCCA = 0 for the purpose of assessing whether the channel is free). Furthermore, I assume the channel as binary (i.e., busy/free). My SensorNodeCSMACA module obtained the CSMA/CA parameters through the par(·) command passed through the .INI file of your simulation.
