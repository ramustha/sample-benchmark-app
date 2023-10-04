#!/bin/sh

echo "Start execution"

echo "Attack http://localhost:9003/spring-tomcat?requestId=tomcat with ${1}qps"
echo "GET http://localhost:9003/spring-tomcat?requestId=tomcat" | ./vegeta.exe -cpus=2 attack -name=sb-tomcat-${1}qps -duration=30s -rate=${1} | tee benchmark/spring-tomcat-${1}qps.bin | ./vegeta.exe report

echo "Creating report"
./vegeta.exe plot --title="sb tomcat with ${1}qps" benchmark/spring-tomcat-${1}qps.bin > benchmark/tomcat-plot.html

echo "Remove test result"
rm benchmark/spring-tomcat-${1}qps.bin

echo "Finish execution"
