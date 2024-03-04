#!/bin/bash

echo "starting traffic from client-1 to client-2"
docker exec clab-srv6-flexalgo-client2 iperf3 -s -p 5202 > /dev/null 2>&1 &
docker exec clab-srv6-flexalgo-client1 iperf3 -c 172.17.44.2 -B 172.17.11.2 -t 1000 -p 5202 -b 2M -l 1450 --udp > /dev/null 2>&1 &
