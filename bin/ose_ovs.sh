#!/bin/bash

echo "=> ovs-vsctl show"
ovs-vsctl show

echo "=> ovs-ofctl -O OpenFlow13 dump-ports-desc br0"
ovs-ofctl -O OpenFlow13 dump-ports-desc br0

echo "=> ovs-ofctl -O OpenFlow13 dump-flows br0"
ovs-ofctl -O OpenFlow13 dump-flows br0 | sed -r -e 's/ cookie=0x[0-9]+, //' -e 's/duration=[0-9.s]+, //' -e 's/n_packets=[0-9]+, //' -e 's/n_bytes=[0-9]+, //'
