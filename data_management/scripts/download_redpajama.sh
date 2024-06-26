#!/bin/bash

datadir=$1
file=$2
split=$3

download_file() {
    local dload_loc=$1
    local datadir=$2
    local line=$3
    local target="${datadir}/${dload_loc}"
   
    if [ -f "$target" ]; then
        echo "File $target already exists, skipping download."
    else
        echo "Downloading $dload_loc"
        mkdir -p "$(dirname "$target")"
        wget -c "$line" -O "$target"
    fi
}


while read line; do
    dload_loc=${line#https://data.together.xyz/redpajama-data-1T/v1.0.0/}
    if [ ! -z "$split" ]; then
        if [[ $dload_loc =~ ^$split/.* ]]; then
            download_file "$dload_loc" "$datadir" "$line"
        fi
    else
        download_file "$dload_loc" "$datadir" "$line"
    fi
done < "$file"
