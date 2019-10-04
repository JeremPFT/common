#! python3

import os
import subprocess

dir_path = os.path.dirname(os.path.realpath(__file__))
root_path = os.path.dirname(dir_path)

myRepositories = [
    "code_generator",
    "code_generator_input_python",
    "code_generator_input",
    "code_generator_model",
    "code_generator_output",
    "common",
    "utils",
]

otherRepositories = [
    "org.opentoken-6.0b",
    "org.stephe_leake.aunit_ext-3.3",
    "org.stephe_leake.makerules-3.3",
    "org.stephe_leake.sal-3.3",
    "org.wisitoken-1.3.0",
]

repositories = myRepositories + otherRepositories

os.chdir(root_path)

modified_repo_list = []

for repo in repositories:
    print("-" * 30 + "\nchecking " + repo + ":", flush=True)

    os.chdir(repo)

    subprocess.call(args = "git remote update",
                    stdout = subprocess.DEVNULL,
                    stderr = subprocess.DEVNULL)

    output = subprocess.check_output(args ="git status",
                                     universal_newlines =True)

    if "is behind" in output or "modified:" in output:
        print(output, flush = True)
        modified_repo_list.append(repo)
    else:
        print("up to date", flush = True)

    os.chdir(root_path)

print("=" * 30 + "\nmodified repositories:")

if len(modified_repo_list) == 0:
    print("none")

for repo in modified_repo_list:
    print(repo)

print("=" * 30)
