#!/usr/bin/python3

import argparse
import os
import sys


TASK_DIR = "{}/vimwiki/study/projects/{}/tasks/"


def getTaskList():
    tasklist = []
    for (root, dirs, files) in os.walk(
        TASK_DIR.format(os.environ["HOME"], os.environ["PROJECT"]), topdown=True
    ):
        for file in files:
            if "_" in file and ".md" in file:
                tasklist.append(file)
    tasklist.sort()
    return tasklist


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-c", "--command", help="task command, i.e. ls, new, subtask", required=True
    )
    parser.add_argument("-d", "--desc", help="description of task, user story")
    parser.add_argument("-i", "--id", help="ID value of task to add subtask to")
    parser.add_argument("-n", "--name", help="task name")
    args = parser.parse_args()

    env = os.environ
    if "PROJECT" not in env:
        print("No valid project. Set as a environment variable")
        sys.exit(1)

    task_home = TASK_DIR.format(os.environ["HOME"], os.environ["PROJECT"])
    tasklist = getTaskList()

    if args.command == "new":
        if args.desc is None or args.name is None:
            print(
                'Invalid usage. Usage: task.py -c new -d "description of task" -n "taskName"'
            )
            sys.exit(1)
        else:
            task_id = int(tasklist[-1].split("_")[0]) + 1
            with open(
                "{}/{}_{}.md".format(task_home, task_id, args.name), "w"
            ) as task_file:
                task_file.write("# USER STORY\n\n")
                task_file.write(args.desc)
                task_file.write("\n\n\n")
                task_file.write("# DEFINITION OF DONE\n\n")
            with open(
                "{}/vimwiki/study/index.md".format(os.environ["HOME"]), "a"
            ) as study_index:
                task_string = "* [ ] [projects {} tasks {}_{}](projects/{}/tasks/{}_{}.md) - {}".format(
                    os.environ["PROJECT"].replace("/", " "),
                    task_id,
                    args.name,
                    os.environ["PROJECT"],
                    task_id,
                    args.name,
                    args.desc,
                )
                study_index.write(task_string)
            with open(
                "{}/vimwiki/study/projects/{}/index.md".format(
                    os.environ["HOME"], os.environ["PROJECT"]
                ),
                "a",
            ) as proj_index:
                task_string = "* [ ] [tasks {}_{}](tasks/{}_{}.md) - {}".format(
                    task_id,
                    args.name,
                    task_id,
                    args.name,
                    args.desc,
                )
                proj_index.write(task_string)

    elif args.command == "ls":
        print("TASK_ID\t\tTASK_NAME")
        for task in tasklist:
            task_id = task.split("_")[0]
            task_name = task.split("_")[1].split(".")[0]
            print("{}\t\t{}".format(task_id, task_name))

    elif args.command == "subtask":
        if args.id is None or args.desc is None:
            print(
                'Invalid usage. Usage: task.py -c subtask -i <id> -d "description of task"'
            )
            sys.exit(1)
        else:
            task_file = (
                os.popen(
                    "ls {}/vimwiki/study/projects/{}/tasks/{}*".format(
                        os.environ["HOME"], os.environ["PROJECT"], args.id
                    )
                )
                .read()
                .strip()
            )
            with open(task_file, "a") as task:
                task_string = "* [ ] {}\n".format(args.desc)
                task.write(task_string)

    else:
        print("Command not supported.")


if __name__ == "__main__":
    main()
