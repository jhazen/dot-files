#!/usr/bin/python3

import argparse
import os
import sys


TASK_DIR = "{}/vimwiki/{}/projects/{}/tasks/"


def getTaskList():
    tasklist = []
    for root, dirs, files in os.walk(
        TASK_DIR.format(os.environ["HOME"],
                        os.environ["REALM"],
                        os.environ["PROJECT"]),
        topdown=True,
    ):
        for file in files:
            if "_" in file and ".md" in file:
                tasklist.append(file)
    tasklist.sort()
    return tasklist


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-c", "--command", help="task command, i.e. ls, new", required=True
    )
    parser.add_argument("-n", "--name", help="task name")
    args = parser.parse_args()

    env = os.environ
    if "PROJECT" not in env:
        print("No valid project. Set as a environment variable")
        sys.exit(1)

    task_home = TASK_DIR.format(
        os.environ["HOME"], os.environ["REALM"], os.environ["PROJECT"]
    )
    project = os.environ["PROJECT"]
    tasklist = getTaskList()

    if args.command == "new":
        if args.name is None:
            print('Invalid usage. Usage: task.py -c new -n "taskName"')
            sys.exit(1)
        else:
            task_id = int(tasklist[-1].split("_")[1].split(".")[0]) + 1
            cleaned_task_id = f"{task_id:05d}"
            with open("{}/{}_{}.md".format(task_home,
                                           project,
                                           cleaned_task_id),
                      "w") as task_file:
                task_file.write("# TICKET\n\n")
                task_file.write("## ID\n\n")
                task_file.write(f"{project}_{cleaned_task_id}\n\n")
                task_file.write("## TITLE\n\n")
                task_file.write(f"{args.name}\n\n")
                task_file.write("## TASKS\n\n")
                task_file.write("* [ ]\n\n")
                task_file.write("## NOTES\n\n")
            print(f"tasks/{project}_{cleaned_task_id}")

    elif args.command == "ls":
        print("TASK_ID\t\tTASK_NAME")
        for task in tasklist:
            task_id = task.split("_")[1].split(".")[0]
            with open(f"{task_home}/{task}", "r") as t:
                for i in range(0, 10):
                    task_name = t.readline().strip()
                    if i == 8:
                        break
            print("{}\t\t{}".format(task_id, task_name))

    else:
        print("Command not supported.")


if __name__ == "__main__":
    main()
