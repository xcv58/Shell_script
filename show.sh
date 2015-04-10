#!/bin/bash
while true; do
    size=$(du -sh .)
    num=$(ls | wc -l)
    time=$(date "+%H:%M:%S")
    echo ${size} ${num} ${time}
    sleep 0.5
done
