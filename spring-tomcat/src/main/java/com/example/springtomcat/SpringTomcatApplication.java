package com.example.springtomcat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@SpringBootApplication
public class SpringTomcatApplication {

  public static void main(String[] args) {
    SpringApplication.run(SpringTomcatApplication.class, args);
  }

}

@RestController
class SampleController {
  private static final Logger LOG = LoggerFactory.getLogger(SampleController.class);

  @GetMapping(value = "/spring-tomcat", produces = MediaType.APPLICATION_JSON_VALUE)
  ResponseEntity<String> getRequest(
      @RequestParam("requestId") String requestId,
      @RequestParam(value = "delay", required = false) Long millis) {
    simulateDelay(requestId, millis);
    return ResponseEntity.ok(requestId + System.nanoTime());
  }

  private void simulateDelay(String requestId, Long millis) {
    try {
      Long delayMillis = Optional.ofNullable(millis).orElse(1000L);
      LOG.info(String.format(
          "simulateDelay = %s from = %s, thread = %s", delayMillis, requestId, Thread.currentThread()));
      Thread.sleep(delayMillis);
    } catch (InterruptedException e) {
      throw new RuntimeException(e);
    }
  }

}
