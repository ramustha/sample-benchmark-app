#!/bin/sh

echo "Start execution"

echo "Attack http://localhost:9002/spring-reactive?requestId=reactive with ${1}qps"
echo "GET http://localhost:9002/spring-reactive?requestId=reactive" | ./vegeta.exe -cpus=2 attack -name=sb-reactive-${1}qps -duration=30s -rate=${1} | tee benchmark/spring-reactive-${1}qps.bin | ./vegeta.exe report

echo "Creating report"
./vegeta.exe plot --title="sb reactive with ${1}qps" benchmark/spring-reactive-${1}qps.bin > benchmark/reactive-plot.html

echo "Remove test result"
rm benchmark/spring-reactive-${1}qps.bin

echo "Finish execution"
