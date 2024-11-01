# Gradle Finder

This script for search gradle.settings and gradlew in Gradle Structure Folder, then call Gradle directly and then execute it.
I created this script for **Code Runner** plugin integration.

**Please Buy Me A Coffe🥺**

<a href="https://trakteer.id/qiubyzhukhi" target="_blank"><img id="wse-buttons-preview" src="https://cdn.trakteer.id/images/embed/trbtn-red-1.png?date=18-11-2023" height="40" style="border:0px;height:40px;" alt="Trakteer Saya"></a>

## Help

usage: main.py --dir DIR --cmd CMD

Look for file gradlew and settings.gradle Then execute Gradle

options:
-h, --help show this help message and exit

--dir DIR The starting directory or file for the search.

--cmd CMD Execute Gradle Args

## Example for main.py (Python Script)

```bash
python main.py --dir=$dir --cmd=assembleDebug
```

## Example for main.sh (Bash Script)

```bash
main $dir assembleDebug
```

## Acode Settings Code Runner Kotlin

this is example for setting json of Code Runner, for Kotlin based by Gradle Project

```json
  {
    "extension": "kt",
    "name": "Kotlin Gradle Project",
    "command": "main.sh $dirNoSlash run"
  },
```

![Preview]("https://github.com/QiubyZ/Gradle-finder/blob/c5651f5085e1e4d1c1d27c586316dae6fc1779ea/preview/acode.gif")
