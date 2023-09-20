
# statistik.sh (1.0.0)

This Bash script analyzes file names with the file extension ".eml" in the current directory. These file names were assigned during the export from an email program and are based on the subject line of the exported emails.

`statistik.sh` uses this information to count the words that occur in the subject. Additionally, it counts email addresses and their domains that appear in the subject. The program summarizes its analysis results in a final report.

Note: The script processes file names with the extension ".eml". If you want to process other file formats, the script needs to be adapted.

## Requirements

This program requires bash version 4 or higher and the following commands: find, mapfile, sed, sort, uniq, grep, rev, date, cat, and rm.

### External Programs Used

| Program Name | Task in the statistics.sh script | Installation on Linux |
|:-------------|:------------------------------|:----------------------|
| find         | Finds files in the current directory | Installed by default |
| sed          | Performs text manipulations | Installed by default |
| uniq         | Filters out duplicate lines | Installed by default |
| sort         | Sorts lines | Installed by default |
| grep         | Filters lines based on patterns | Installed by default |

The mentioned programs are usually available by default on Linux.

## Installation

To install this program, copy the file `statistik.sh` to a directory of your choice and make the script file executable with the following command:

```bash
chmod +x statistik.sh
```

If you want to be able to invoke the script from any directory, it needs to be stored in a directory that is part of the search path. You can display the search path using the command `echo "$PATH"` and extend it if necessary or desired by editing the file `~/.bashrc` or the file `/etc/bash.bashrc`. The file `~/.bashrc` defines the search path for a user; `/etc/bash.bashrc` defines it system-wide for all users.

## Usage

1. Navigate to the directory where the script is stored.
2. Open a terminal and execute the following command:

### If the script is in the search path:

```bash
statistik.sh
```

### If the script is in the current directory but not in the search path:

```bash
./statistik.sh
```

The script analyzes all file names with the file extension ".eml" in the current directory and writes a text file named `spam_statistik` to this directory as a final report, listing the words and their frequency as well as the email addresses and email domains found in the subject lines.

## Author

Bernd Storck: I am a certified webmaster/web developer and Linux aficionado from Berlin. I had my first programming experiences around 1984 with an ATARI 800XL.

Contact: [Facebook: Linux-Infos von Bernd Storck](https://www.facebook.com/BStLinux/), [www.facebook.com/BStLinux](https://www.facebook.com/BStLinux/)

## License

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You will find the GNU General Public License at <http://www.gnu.org/licenses/>.
