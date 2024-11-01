#!/usr/bin/python

import os
import argparse
from subprocess import run


def find_parent_files(start_path, filenames):
    current_path = os.path.abspath(start_path)
    if not os.path.exists(current_path):
        return None
    found_files = {}
    while True:
        parent_path = os.path.dirname(current_path)
        if parent_path == current_path:
            break
        current_path = parent_path
        for filename in filenames:
            if os.path.exists(os.path.join(current_path, filename)):
                found_files[filename] = os.path.join(current_path, filename)
        if len(found_files) == len(filenames):
            break

    return found_files if found_files else None


def main():
    parser = argparse.ArgumentParser(
        description="Look for file gradlew and settings.gradle Then execute Gradle"
    )
    parser.add_argument(
        "--dir", required=True, help="The starting directory or file for the search."
    )
    parser.add_argument("--cmd", required=True, help="Execute Gradle Args")
    args = parser.parse_args()
    try:
        start_path = args.dir
        gradle_args = args.cmd

        filenames = ["gradlew", "settings.gradle", "settings.gradle.kts"]

        result = find_parent_files(start_path, filenames)

        if result:
            found_paths = []
            for filename, filepath in result.items():
                print(f"File {filename} found in: {filepath}")
                found_paths.append(filepath)

            common_path = os.path.commonpath(found_paths)
            print(common_path)
            run(f"cd {common_path} && gradle {gradle_args}", shell=True)
        else:
            print("File not found in parent path.")

    except Exception as e:
        print(f"There is an error: {e}")


if __name__ == "__main__":
    main()
