from datetime import datetime, timedelta
from pymongo import MongoClient
import smtplib

# max time allowed since last report (seconds)
max_allowed_time_hours = 6
max_allowed_time_seconds = max_allowed_time_hours * 3600 # hours => seconds


def init_db():
    global client; client = MongoClient()
    global db; db = client.themo


def send_alarm(subject, text, receivers):
    sender = 'themo@univ.haifa.ac.il'
    SUBJECT = subject
    TEXT = text
    message = 'Subject: {}\n\n{}'.format(SUBJECT, TEXT)

    try:
       smtpObj = smtplib.SMTP('mr1.haifa.ac.il')
       smtpObj.sendmail(sender, receivers, message)
       print("Successfully sent email")
    except SMTPException:
       print("Error: unable to send email")


def check_last_report(filter):
    print("-I-   filter: " + str(filter))

    # the latest doc in our DB
    last_doc = db.samples.find(filter).sort([ ("d_stamp",-1),("t_stamp",-1) ]).limit(1)[0]

    # extract time stamp from this doc
    last_report = last_doc["d_stamp"] + " " + last_doc["t_stamp"]
    last_report = datetime.strptime(last_report, '%Y-%m-%d %H:%M:%S')

    # the delta from now
    now = datetime.now()
    delta = now - last_report

    if delta.total_seconds() > max_allowed_time_seconds:
        return False
    else:
        return True


def check_battery_level():
    low_batteries = []
    for battery_id in ["1", "2", "3"]:
        last_doc = db.samples.find({"sensor_name" : "battery", "battery_id" : battery_id}).sort([ ("d_stamp",-1),("t_stamp",-1) ]).limit(1)[0]
        if last_doc["level"] < 11.5:
            low_batteries.append("battery_" + str(battery_id) + ": " + str(last_doc["level"]))

        if len(low_batteries) > 0:
            print("-I- battery:alert")
            subject = "Themo alert - battery low level"
            receivers = ["imardix@univ.haifa.ac.il", "sdahan3@univ.haifa.ac.il"]
            text = "battery level is too low for: "

            for bat in low_batteries:
                text = text + "\n" + bat

    send_alarm(subject, text, receivers)


def check_individual_sensors():
    print("-I- checking last report of each sensor")
    dead_sensors = []
    for filter in [ {"sensor_name" : "dcs"}, {"sensor_name" : "adcp"}, {"sensor_name" : "flntu"},
                    {"sensor_name" : "microcat"},  {"sensor_name" : "metpak"}, {"sensor_name" : "s9"},
                    {"sensor_name" : "windsonic"}, {"sensor_name" : "mp101a_humidity"}, {"sensor_name" : "mp101a_temprature"},
                    {"sensor_name" : "barometer"}, {"sensor_name" : "waves"}, {"sensor_name" : "battery"} ]:

        if not check_last_report(filter):
            dead_sensors.append(filter["sensor_name"])

    if len(dead_sensors) > 0:
        print("-I- check_individual_sensors:alert")
        subject = "Themo alert - no data from sensors"
        receivers = ["imardix@univ.haifa.ac.il", "sdahan3@univ.haifa.ac.il"]
        text = "During the last " + \
                str(max_allowed_time_hours) + " hours, no data was received from the following sensors:"
        for sensor in dead_sensors:
            text = text + "\n" + sensor

    send_alarm(subject, text, receivers)


#----------  Main Body  ------------#
init_db()
check_battery_level()
check_individual_sensors()
client.close()
