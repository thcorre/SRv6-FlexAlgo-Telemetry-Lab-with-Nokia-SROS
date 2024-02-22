# SRv6 FlexAlgo Telemetry Lab Demo (Nokia SR OS)

* Transport: Base SRv6 (end-dt46), FlexAlgo 128 (with STAMP dynamic delay measurement)
* Service: EVPN IFL (Interface-less)

The purpose of this pre-configured lab is to demonstrate the use of an end-to-end SRv6 transport on Nokia routers spanning from Access/Aggregation (7250 IXR Gen2/2c) to Edge/Core (7750 SR FP4/FP5-based).
This is realised based on usage of a Flexible Algorithm 128 with delay used as a metric condition to achieve the lowest latency path.
A GPG (gnmic/prometheus/grafana) stack is used to collect and report all the objects via Telemetry (gRPC):

![Screenshot 2024-02-22 at 11 33 58 AM](https://github.com/thcorre/SRv6-with-Nokia-SROS/assets/12113139/cbc7fe81-b6be-46fc-a4c6-e88f9774e6ee)

Grafana dashboards are provided to check the latency in "real" time (5-10s updates).
One Linux client sending traffic to another client (unidirectional) through a L3VPN (EVPN IFL).

A fine-grained control on links delay can be achieved via tc cmd on the host or directly through containerlab cmd to influence the lowest latency path.


