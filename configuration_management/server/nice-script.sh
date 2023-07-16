#! /usr/bin/bash
set -e # stop if it fails at any point

CYAN='\033[1;36m'
NO_COLOR='\033[0m'
LABEL="LIST ALL MOUNTED FILESYSTEMS"
printf "${CYAN}====== ${LABEL}${NO_COLOR}\n"

df -h
