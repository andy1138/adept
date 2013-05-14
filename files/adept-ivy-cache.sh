#!/usr/bin/env bash

http_prefix=http://freekh.github.io/adept/files/
jar_location="$http_prefix"adept-tools-assembly-0.1-SNAPSHOT.jar
jar_file=$(mktemp -t adept-ivy)
zip_file=$(mktemp -t adept-ivy)
output=$(mktemp -t adept-ivy)

echo "downloading adept ivy scanner (includes scala libraries so be patient!) to: $jar_file..."
curl $jar_location > $jar_file


java -jar $jar_file $output

zip "$zip_file.zip" $output

echo "cleaning up..."
rm $jar_file
rm $output


echo "send file: $zip_file.zip to fredrik.ekholdt@typesafe.com"

