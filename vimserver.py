#!/usr/bin/env python3

import yaml
import os
import argparse
import subprocess

servers = []
names = []
ips = []
list_location = os.environ.get("VAGRANTLAB")

fp_map = {
    "wildfly11": 8080,
    "web": 8080,
    "ci": 8080,
    "db": 5432
}

parser = argparse.ArgumentParser()
parser.add_argument("-c", "--chef", help="set provisioner to chef (salt is default)", action="store_true")
parser.add_argument("role", type=str, help="Name of saltstack role to apply. i.e. appserver")
args = parser.parse_args()

if args.chef:
    provisioner = "chef"
else:
    provisioner = "salt"

if args.role in fp_map:
    fp = True
else:
    fp = False

with open("{}/servers.yaml".format(list_location), 'r') as file:
    servers = yaml.load(file)

for server in servers:
    names.append(server["name"])
    ips.append(server["ip"])

for id in range(1, 99):
    tag = "s{}".format(id)
    if tag in names:
        continue
    else:
        break

for val in range(102, 210):
    addr = "10.1.0.{}".format(val)
    if addr in ips:
        continue
    else:
        hport = val + 8000
        break

if fp:
    fp_yaml =  "forwarded_port:\n"
    fp_yaml += "    - guest: {}\n".format(fp_map[args.role])
    fp_yaml += "      host: {}\n  ".format(hport)
else:
    fp_yaml = ""

final_yaml = """
- name: {}
  box: centos/7
  ip: {}
  provision: {}
  temp: true
  {}role: {}""".format(tag, addr, provisioner, fp_yaml, args.role)

with open("{}/servers.yaml".format(list_location), 'a') as result_file:
    result_file.write(final_yaml)

subprocess.Popen("startVM.sh {}".format(tag), shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
print("Server {} has been requested and is booting. IP: {}".format(tag, addr))
if fp:
    print("Port forwarding enabled. Guest port {} -> host port {}".format(fp_map[args.role], hport))
