import os
from datetime import datetime
import argparse
import configparser

# TODO:
# 1. Sound, Notifications
# 2. Play nice with other left-status things?
#   a. Powerline?
#   b. Split across different tmux sessions?
# 3. Better configuration. 
#   a. Get options from tmux
#   b. Configure short cuts?
# 4. Package dependencies?
# 5. Better serialization? Pickle instead of parsing from text files?
# 6. Set intention
#   a. Be sure to log them too.
# 7. Needs to log additional sessions when timer rolls over.
# 8. Make it more responsive?
# 9. Seperate timers for seperate workspaces? Store that in logging information

os.chdir(os.path.dirname(__file__))

# Gets the parameters. Fills them in from default.config and then overwrites them with
# tmux params @poms_$same_name if they are defined.
# TODO: get parameters from tmux
def get_configuration_arguments():
    config = configparser.ConfigParser()
    config.read('../default.config')
    args = {}
    args["work_time"] = config["Default"].getint("work_time")
    args["break_time"] = config["Default"].getint("break_time")
    args["color_work_fg"] = config["Default"]["color_work_fg"]
    args["color_work_bg"] = config["Default"]["color_work_bg"]
    args["color_break_fg"] = config["Default"]["color_break_fg"]
    args["color_break_bg"] = config["Default"]["color_break_bg"]
    args["time_log_file"] = config["Default"]["time_log_file"]
    args["pom_log_file"] = config["Default"]["pom_log_file"]
    return args
config_args = get_configuration_arguments()

time_format = "%m/%d/%Y, %H:%M:%S"
n = datetime.now()

parser = argparse.ArgumentParser(description='manages pomodoros')
group = parser.add_mutually_exclusive_group()
group.add_argument('--start', dest='action', action="store_const", const="start", help="start a new timer")
group.add_argument('--get_time', dest='action', action="store_const", const="get_time", help="get the time on the current timer.")
group.add_argument('--stop', dest='action', action="store_const", const="stop", help="stop the timer")
args = parser.parse_args()

# Start also functions as a reset
if args.action == "stop" or args.action == "start":
    if os.path.exists(config_args["time_log_file"]):
        os.remove(config_args["time_log_file"])
        if args.action == "stop":
            with open(config_args["pom_log_file"], 'r') as fin:
                data = fin.read().splitlines(True)
            with open(config_args["pom_log_file"], 'w') as fout:
                fout.writelines(data[:-1])
    if args.action == "stop":
        exit()

if args.action == "start":
    with open(config_args["time_log_file"], 'w') as f:
        f.write(n.strftime(time_format))
    with open(config_args["pom_log_file"], 'a+') as f:
        f.write(n.strftime(time_format) + '\n')
    exit()


with open(config_args["time_log_file"]) as f:
    time =  datetime.strptime(f.readline(), time_format)
seconds = ((n-time).seconds) % ((config_args["work_time"] + config_args["break_time"])*60)
if seconds < 3:
    new = False
    with open(config_args["pom_log_file"]) as f:
        data = f.read().splitlines(True)
        print(data)
        last = datetime.strptime(data[-1].strip(), time_format)
        if (n-last).seconds > 60*config_args["work_time"]:
            new = True
    if new:
        with open(config_args["pom_log_file"], 'a+') as f:
            f.write(n.strftime(time_format)) # TODO: reduce code duplication here
if seconds <= config_args["work_time"] * 60:
    seconds = config_args["work_time"] * 60 - seconds
    print("#[fg=%s,bg=%s]%02d:%02d"%(config_args["color_work_fg"],config_args["color_work_bg"], seconds//60, seconds % 60))
else:
    seconds = seconds - config_args["work_time"] * 60
    print("#[fg=%s,bg=%s]%02d:%02d"%(config_args["color_break_fg"], config_args["color_break_bg"],seconds//60, seconds % 60))
