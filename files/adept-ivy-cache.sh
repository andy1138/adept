#!/usr/bin/env bash

tmp_dir=$PWD/tmp
mkdir -p $tmp_dir


http_prefix=http://freekh.github.io/adept/files/

scala_version="2.9.2"

adept_tools_version="0.1-SNAPSHOT"

report_name="report-$(date +%s)"

output="$tmp_dir/$report_name"
zip_file="$PWD/$report_name.zip"

jar_name="adept-tools_$scala_version-$adept_tools_version.jar"
jar_location="$http_prefix$jar_name"
jar_file="$tmp_dir/$jar_name"
scala_lib="$HOME/.ivy2/cache/org.scala-lang/scala-library/jars/scala-library-$scala_version.jar"
main_class="adept.tools.AdeptIvyCacheReader"


echo "checking ivy2 cache has scala library $scala_version..."
if [ ! -f $scala_lib  ]; then
    echo "could not find scala lib: $scala_lib. downloading..."
    scala_lib="$tmp_dir/scala-library-$scala_version.jar"
    curl http://repo1.maven.org/maven2/org/scala-lang/scala-library/2.9.2/scala-library-2.9.2.jar > $scala_lib
fi


echo "downloading adept ivy scanner from $jar_location to $jar_file..."
curl $jar_location > $jar_file

cmd="java -cp $scala_lib:$jar_file $main_class $output"
echo "executing $cmd..."
eval $cmd

echo "zipping to $zip_file..."
zip "$zip_file" $output

read -p "hit any key to clean up (remove $tmp_dir), or do ctrl+c to abort..."

rm -r $tmp_dir

echo "removed $tmp_dir!"

echo "send file: $zip_file.zip to fredrik.ekholdt@typesafe.com"

