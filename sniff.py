#! /usr/bin/env python
#.\sniff.py < some.pcap

from scapy.all import *
from collections import Counter

packet_tuplecounts = Counter()
packet_IPcounts = Counter()

def pkttuplesummary(packet):
    key = tuple(sorted([packet[0][1].src, packet[0][1].dst]))
    packet_tuplecounts.update([key])
    return "{} {} {}".format(packet_tuplecounts.values(), packet[0][1].src, packet[0][1].dst  )

def pktIPsrcsummary(packet):
    key = packet[0][1].src
    packet_IPcounts.update([key])

data=rdpcap(sys.stdin)
#print data.summary()

for pkts in data:
   if IP in pkts:
        pkttuplesummary(pkts)
        pktIPsrcsummary(pkts)

print "IP tuples"
for IP, count in packet_tuplecounts.items():
    print  IP[0], IP[1], count

print "\nIP src TX packets"
for IP, count in sorted(packet_IPcounts.items()):
   print IP, count
