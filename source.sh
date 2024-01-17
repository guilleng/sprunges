#!/bin/env bash

# Set a temp file that keep track of pastebins
sprunges="/tmp/sprunges/${USER}.$(date +%d%m%Y)"

if [ ! -d "/tmp/sprunges" ]; then
  mkdir -p /tmp/sprunges
fi

if [ ! -f "${sprunges}" ]; then
  touch "${sprunges}"
fi

# Get the number of lines in file
n=$(wc -l < "${sprunges}")

function usage() { 
  cat <<EOF
    Usage: $(basename "${0}") [options] <value>

    fetch/post pastebins to https://sprunge.us. Track IDs in a /tmp file. 

    If no FILE specified, reads from stdin.

    -d [DESCRIPTION]     add a DESCRIPTION to the entry
    -f [FILE]            oupload FILE 
    -h                   show this help
    -l                   list pastebins table
    -n                   don't record URL to /tmp file
    -o                   output URL of uploaded pastebin to stdout
    -r [INDEX | ID]      retrieve pastebin by INDEX or ID 
EOF
  exit 0
}

function list_table() {
  if [ -s "${sprunges}" ]; then
    cat "${sprunges}"
  else
    echo "Pastebins table empty"
  fi
  exit 0
}

# Exits 0 for non-negative integers
function is_number() {
  case ${1} in 
    ''|*[!0-9]*) 
      false ;;
    *) 
      true ;; 
  esac
}

function retrieve_by_index() {
  ((fetch++))
  if [ "${fetch}" -le "${n}" ]; then 
    url=$(awk -v line="${fetch}" '{if (NR == line) print $2}' "${sprunges}")
    curl "${url}"
  else
    echo "-r invalid index"
  fi
}

function retrieve() {
  if is_number "${fetch}"; then
    retrieve_by_index
  else
    curl "https://sprunge.us/${fetch}"
  fi
}

function upload_data() {
  if [ -z "${input}" ]; then
    input=/dev/stdin
  fi

  url=$(curl -s --show-error -F 'sprunge=<-' http://sprunge.us < "${input}")
  code=$?
  if [ ! "${code}" -eq 0 ]; then
    echo "Error uploading data: curl exited ${code}"
    return
  fi

  if [ -z "${no_save}" ]; then
    echo -e "[${n}]\t ${url}\t ${description}\t" >> "${sprunges}"
  fi
  if [ -n "${show_url}" ]; then
    echo "${url}"
  fi
}
