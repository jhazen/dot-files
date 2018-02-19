#!/usr/bin/env python3

import yaml
import os
import argparse
import subprocess

servers = []
names = []
ips = []
list_location = os.environ.get("VAGRANTLAB")

parser = argparse.ArgumentParser()
parser.add_argument("role", type=str, help="Name of saltstack role to apply. i.e. appserver")
args = parser.parse_args()


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
        break

final_yaml = """
- name: {}
  box: centos/7
  ip: {}
  provision: salt
  role: {}""".format(tag, addr, args.role)

with open("{}/servers.yaml".format(list_location), 'a') as result_file:
    result_file.write(final_yaml)

subprocess.Popen("cd {} && vagrant up {}".format(list_location, tag), shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
print("Server {} has been requested and is booting. IP: {}".format(tag, addr))
