#!/bin/env sh

# Get the true path of this script to source functions
script=$(test -L "${0}" && readlink -n "${0}" || echo "${0}")
path=$(dirname "${script}")
# shellcheck source=./source.sh
. "${path}/source.sh"

while getopts ":d:f:hlnor:" option; do
  case ${option} in
    d)
      description="${OPTARG}"
      ;;
    f)
      if [ -r "${OPTARG}" ]; then
        input=${OPTARG}
      else
        echo "Can't read file ${OPTARG}"
        exit 1
      fi
      ;;
    h)
      usage
      ;;
    l)
      list_table
      ;;
    n)
      no_save=true
      ;;
    o)
      show_url=true
      ;;
    r)
      fetch=${OPTARG}
      retrieve
      exit
      ;;
    ?)
      usage
      ;;
  esac
done

upload_data 
exit
