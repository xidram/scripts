import glob
import io

time_keys = {}
src_type = "nmea"
src_type = "log"

src_dir="/home/ilan/Downloads/gpsdata_buoy_20171126"
src_dir="/home/ilan/Downloads/gpsdata_buoy_20171203"
src_dir="/home/ilan/Downloads/gps_data_BU353_20171203"

out = open(src_dir + "/bu353_20171203.csv", 'w')

for nmea in glob.glob(src_dir + "/*." + src_type):
    fo = io.open(nmea,'r',encoding='utf-8',errors='ignore')

    for line in fo:
        if line.startswith("$GPRMC"):
            line = line.rstrip("\n\r")
            print(line)
            fields = line.split(',')
            t_stamp = fields[1].split('.')[0]
            d_stamp = fields[9]
            # if d_stamp != "031217":
            #     continue
            latitude = " ".join(fields[3:5])
            longitude = " ".join(fields[5:7])
            time_key = d_stamp + "_" + t_stamp

            print("date: " + d_stamp)
            print("time: " + t_stamp)
            print("latitude: " + latitude)
            print("longitude: " + longitude)

            if time_key not in time_keys:
                out_line = '{}, {}, {}, {}'.format(d_stamp, t_stamp, latitude, longitude)
                out.write(out_line + "\n")
                time_keys[time_key] = 1

out.close()
fo.close()
