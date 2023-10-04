#!/bin/sh

echo "Start execution"

echo "Attack http://localhost:9001/spring-kotlin?requestId=kotlin with ${1}qps"
echo "GET http://localhost:9001/spring-kotlin?requestId=kotlin" | ./vegeta.exe -cpus=2 attack -name=sb-kotlin-${1}qps -duration=30s -rate=${1} | tee benchmark/spring-kotlin-${1}qps.bin | ./vegeta.exe report

echo "Attack http://localhost:9003/spring-tomcat?requestId=tomcat with ${1}qps"
echo "GET http://localhost:9003/spring-tomcat?requestId=tomcat" | ./vegeta.exe -cpus=2 attack -name=sb-tomcat-${1}qps -duration=30s -rate=${1} | tee benchmark/spring-tomcat-${1}qps.bin | ./vegeta.exe report

echo "Attack http://localhost:9002/spring-reactive?requestId=reactive with ${1}qps"
echo "GET http://localhost:9002/spring-reactive?requestId=reactive" | ./vegeta.exe -cpus=2 attack -name=sb-reactive-${1}qps -duration=30s -rate=${1} | tee benchmark/spring-reactive-${1}qps.bin | ./vegeta.exe report

echo "Creating report"
./vegeta.exe plot --title="vegeta plot with ${1}qps" benchmark/spring-kotlin-${1}qps.bin benchmark/spring-reactive-${1}qps.bin benchmark/spring-tomcat-${1}qps.bin > benchmark/combine-plot.html

echo "Remove test result"
rm benchmark/spring-kotlin-${1}qps.bin benchmark/spring-reactive-${1}qps.bin benchmark/spring-tomcat-${1}qps.bin

echo "Finish execution"
