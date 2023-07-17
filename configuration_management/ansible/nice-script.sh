#! /usr/bin/bash
set -e # stop if it fails at any point

CYAN='\033[1;36m'
NO_COLOR='\033[0m'
LABEL="LIST OF ALL MOUNTED FILESYSTEMS"
printf "${CYAN}====== ${LABEL}${NO_COLOR}\n"

mount

CYAN='\033[1;36m'
NO_COLOR='\033[0m'
LABEL="DISK DETAILS ON FILESYSTEMS"
printf "${CYAN}====== ${LABEL}${NO_COLOR}\n"

df -h