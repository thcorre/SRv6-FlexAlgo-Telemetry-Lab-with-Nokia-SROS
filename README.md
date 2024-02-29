# SRv6 FlexAlgo Telemetry Lab (Nokia SR OS)

Objective: Creating a traffic-engineered path between R1 and R5 that uses delay as a metric.
* Transport: Base SRv6 (end-dt46) and FlexAlgo 128 (with STAMP dynamic delay measurement)
* Service: EVPN IFL (Interface-less)

The purpose of this pre-configured lab is to demonstrate the use of an end-to-end SRv6 transport on Nokia routers spanning from Access/Aggregation (7250 IXR Gen2/2c) to Edge/Core (7750 SR FP4/FP5-based).
This is based on usage of a Flexible Algorithm (Algo 128) with delay used as a metric condition to achieve the lowest latency path.

Nowadays, observability is becoming essential for every organisation.
An open source GPG (gnmic/prometheus/grafana) stack is used to collect and report all the objects of interest via Telemetry/gRPC (links delay, interfaces state, metrics, cpu, mem, etc.):

![Screenshot 2024-02-22 at 11 33 58 AM](https://github.com/thcorre/SRv6-with-Nokia-SROS/assets/12113139/cbc7fe81-b6be-46fc-a4c6-e88f9774e6ee)

Grafana dashboards are provided to check the latency in "real" time (5-10s updates).
One Linux client sending traffic to another client (unidirectional) through a L3VPN (EVPN IFL).

## Requirements
Versions used are:
* containerlab 0.51.3 (latest version at time of writing)
* vr-sros 23.10.R3 (requires license)

SROS image was created using [VR Network Lab](https://github.com/vrnetlab/vrnetlab)
IMPORTANT: vr-sros must be set as an image in docker to be pull directly by containerlab
```
# docker images | grep vr-sros
vr-sros                               23.10.R3         6725f1548692   3 days ago      1.43GB
```

## Deploying the lab
The lab is deployed with the [containerlab](https://containerlab.dev/) project, where srv6-flexalgo.clab.yml file declaratively describes the lab topology.
```
containerlab deploy --reconfigure
```
To remove the lab:
```
containerlab destroy --cleanup
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

A fine-grained control on links delay can be achieved via tc cmd on the host or directly through containerlab cmd to influence the lowest latency path.


