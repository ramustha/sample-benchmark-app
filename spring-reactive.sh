#!/bin/sh

echo "Start execution"

echo "Attack http://localhost:9002/spring-reactive?requestId=1696326661335 with ${1}qps"
echo "GET http://localhost:9002/spring-reactive?requestId=1696326661335" | ./vegeta/vegeta.exe -cpus=2 attack -name=spring-reactive-${1}qps -duration=30s -rate=${1} > vegeta/spring-reactive-results.${1}qps.bin

echo "Attack http://localhost:9001/spring-kotlin?requestId=1696326617067 with ${1}qps"
echo "GET http://localhost:9001/spring-kotlin?requestId=1696326617067" | ./vegeta/vegeta.exe -cpus=2 attack -name=spring-kotlin-${1}qps -duration=30s -rate=${1} > vegeta/spring-kotlin-results.${1}qps.bin

echo "Attack http://localhost:9003/spring-tomcat?requestId=1696328670297 with ${1}qps"
echo "GET http://localhost:9003/spring-tomcat?requestId=1696328673915" | ./vegeta/vegeta.exe -cpus=2 attack -name=spring-tomcat-${1}qps -duration=30s -rate=${1} > vegeta/spring-tomcat-results.${1}qps.bin


echo "Creating report"
./vegeta/vegeta.exe plot --title="vegeta plot with ${1}qps" vegeta/spring-kotlin-results.${1}qps.bin vegeta/spring-reactive-results.${1}qps.bin vegeta/spring-tomcat-results.${1}qps.bin > vegeta/combine-plot.html

echo "Finish execution"
