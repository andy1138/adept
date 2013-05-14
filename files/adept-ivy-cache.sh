#!/usr/bin/env bash

http_prefix=http://freekh.github.io/adept/files/
jar_location="$http_prefix"adept-tools-assembly-0.1-SNAPSHOT.jar
jar_file=$(mktemp -t adept-ivy)
output=$(mktemp -t adept-ivy)

echo "downloading adept ivy scanner..."
curl $jar_location > $jar_file


java -jar $jar_file $output

echo "send file: $output to freekh@gmail.com"
