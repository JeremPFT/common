#! python3

import os
import subprocess

dir_path = os.path.dirname(os.path.realpath(__file__))
root_path = os.path.dirname(dir_path)

print(dir_path)
print(root_path)

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

print(repositories)

os.chdir(root_path)

# subprocess.run(["ls", "-l"])


reposToDo = []

erase1 = []
erase = [
    "On branch master\n",
    "Your branch is up-to-date with 'origin/master'.\n",
    "nothing to commit, working directory clean\n",
    '  (use "git pull" to update your local branch)',
    '  (use "git add <file>..." to update what will be committed)\n',
    '  (use "git checkout -- <file>..." to discard changes in working directory)\n\n',
    '  (use "git add <file>..." to include in what will be committed)\n\n',
    'no changes added to commit (use "git add" and/or "git commit -a")\n',
    "Fetching origin\n",
]

for repo in repositories:
    print("-" * 30 + "\nchecking " + repo + ":", flush=True)

    os.chdir(repo)
    subprocess.run(args="git remote update")
    output = subprocess.check_output(args="git status", universal_newlines=True)

    for substring in erase:
        output = output.replace(substring, "")

    if output == "":
        print("up to date", flush=True)
    else:
        print(output, flush=True)
        reposToDo.append(repo)
    os.chdir(root_path)

print("=" * 30 + "\nmodified repositories:")
if len(reposToDo) == 0:
    print("none")
for repo in reposToDo:
    print(repo)
print("=" * 30)
