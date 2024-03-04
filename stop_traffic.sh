#!/bin/bash

echo "stopping traffic from client-1 to client-2"
docker exec clab-srv6-flexalgo-client2 pkill iperf3 > /dev/null 2>&1 &
docker exec clab-srv6-flexalgo-client1 pkill iperf3 > /dev/null 2>&1 &
