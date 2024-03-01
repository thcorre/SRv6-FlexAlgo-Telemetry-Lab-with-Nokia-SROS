# SRv6 FlexAlgo Telemetry Lab (Nokia SR OS)

Objective: Creating a traffic-engineered path based on SRv6 transport between 2 endpoints (R1 and R5) that uses delay as a metric to provide lowest latency connectivity between 2 clients over a L3VPN.
* Transport: Base [SRv6](https://www.nokia.com/networks/ip-networks/segment-routing/) (end-dt46) and FlexAlgo 128 (with STAMP dynamic delay measurement)
* Service: [EVPN](https://www.nokia.com/networks/ethernet-vpn/) IFL (Interface-less)

The purpose of this pre-configured lab is to demonstrate the use of an end-to-end SRv6 transport on Nokia SR OS routers spanning from Access/Aggregation ([7250 IXR](https://www.nokia.com/networks/ip-networks/7250-interconnect-router/) Gen2/2c) to Edge/Core ([7750 SR](https://www.nokia.com/networks/ip-networks/7750-service-router/) FP4/FP5-based).
This is based on usage of a Flexible Algorithm (Algo 128) with delay used as a metric condition to achieve the lowest latency path.

Nowadays, observability is becoming essential for every organisation.
An open source GPG ([gnmic](https://gnmic.openconfig.net/)/[prometheus](https://prometheus.io/)/[grafana](https://grafana.com/)) telemetry stack is used to collect and report all the objects of interest via Telemetry/gRPC (links delay, interfaces state, metrics, cpu, mem, etc.):

![Screenshot 2024-02-22 at 11 33 58 AM](https://github.com/thcorre/SRv6-with-Nokia-SROS/assets/12113139/cbc7fe81-b6be-46fc-a4c6-e88f9774e6ee)

Grafana dashboards are provided to check:
* The state of the interfaces for each node
* The latency on the links in "real" time (delay measurement interval via STAMP)
* The number of BGP peers/routes per node
* The CPU/memory per node

## Requirements
Versions used are:
* [containerlab](https://containerlab.dev/) 0.51.3 (latest version at time of writing)
* [nokia_sros](https://containerlab.dev/manual/kinds/vr-sros/) 23.10.R3 (requires license)

SR OS VM image can be created as docker container using [VR Network Lab](https://github.com/vrnetlab/vrnetlab)
IMPORTANT: vr-sros must be set as an image in docker to be pull directly by containerlab
```
# docker images | grep vr-sros
vrnetlab/nokia_sros                               23.10.R3         6725f1548692   3 days ago      1.43GB
```

## Deploying the lab
The lab is deployed with the [containerlab](https://containerlab.dev/) project, where [`srv6-flexalgo.clab.yml`](srv6-flexalgo.clab.yml) file declaratively describes the lab topology.
```
clab deploy --reconfigure
```
To remove the lab:
```
clab destroy --cleanup
```

## Accessing the network elements
Once the lab has been deployed, the different SR Linux nodes can be accessed via SSH through their management IP address, given in the summary displayed after the execution of the deploy command. It is also possible to reach those nodes directly via their hostname, defined in the topology file. Linux clients cannot be reached via SSH, as it is not enabled, but it is possible to connect to them with a docker exec command.

```bash
# reach a SR OS IP/MPLS router via SSH
ssh admin@clab-srv6-flexalgo-R1
ssh admin@clab-srv6-flexalgo-R5

# reach a Linux client via Docker
docker exec -it client1 bash
```

One Linux client (Client1) is sending unidirectional traffic to another client (Client2) through a L3VPN (EVPN IFL).
A fine-grained control on links delay can be achieved via tc cmd on the host or directly through containerlab cmd to influence the lowest latency path.


