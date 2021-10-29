#!/usr/bin/python3
#encoding=utf-8

import sys
import os
import json
import sqlite3
from datetime import datetime
import logging
import errno
import pandas as pd

def main(fname):
#       logging.basicConfig(filename='proc.log', level=logging.INFO)
#       logging.info("Processing: %s" % fname)

        if not os.path.exists(fname):
                logger.error("Kismet DB not found!! "+str(fname))
                raise FileNotFoundError(
                        errno.ENOENT, os.strerror(errno.ENOENT), fname)

        conn = sqlite3.connect(fname)
        c = conn.cursor()

        c.execute('SELECT device FROM devices WHERE phyname="IEEE802.11" AND type="Wi-Fi AP"')

        dataextract = c.fetchall()
        #logging.info(dataextract)
        outfilename = (''.join(fname.split('.')[:-1])) + ('.CSV')
        htmlfilename = (''.join(fname.split('.')[:-1])) + ('.html')
        #logging.debug("saving to %s" % outfilename)

        outfile = open(outfilename, 'w')
        htmlfile = open(htmlfilename, 'w')
        lines = 0
        # header:
        outfile.write('MAC,FirstTimeSeen,LastTimeSeen,Channel,Auth,RSSI,SSID\n')

        for row in dataextract:
                jsonextract = json.loads(row[0])

                mac = jsonextract['kismet.device.base.macaddr']
                ssid = jsonextract['kismet.device.base.name']
                auth = jsonextract['kismet.device.base.crypt']
                first = str(datetime.fromtimestamp(jsonextract['kismet.device.base.first_time']))
                last = str(datetime.fromtimestamp(jsonextract['kismet.device.base.last_time']))
                chan = jsonextract['kismet.device.base.channel']
                #rssi = jsonextract['kismet.device.base.signal']['kismet.common.signal.max_signal']
                try: rssi = jsonextract['kismet.device.base.signal']['kismet.common.signal.max_signal']
                except KeyError: pass
                outfile.write(mac+','+first+','+last+','+chan+','+auth+','+str(rssi)+','+ssid+'\n')
                lines = lines + 1

        # clear memory
        dataextract = None
        outfile.close()
        #logging.debug("File done. " + str(lines) + " WIFI Devices")

        columns = ['BSSID', 'FirstTime', 'LastTime', 'Channel', 'Auth', 'RSSI','SSID']
        df = pd.read_csv(outfilename, skiprows=[0], names=columns, index_col=0)
        #df.to_html("table.html")
        df.to_html(htmlfilename)

def print_usage():
        print("Usage: *.kismet *.kismet *.kismet... ")
        print("Description: ")
        print("Converts Kismetdb logfile to csv")


if __name__ == "__main__":
        print("Kismet DB to CSV/html table \n")

        if sys.version_info[0] < 3:
                print("This script requires Python 3")
                sys.exit(-1)

        if len(sys.argv) < 2:
                print_usage()
                sys.exit(-1)
        else:
                for p in sys.argv[1:]:
                        if p[0] != "-":
                                if not os.path.exists(p):
                                        print("File not found: %s" % p)
                                        continue

                                r = main(p)
