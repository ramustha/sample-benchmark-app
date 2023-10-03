package com.example.springreactive;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;

import java.time.Duration;
import java.util.Optional;

@SpringBootApplication
public class SpringReactiveApplication {

  public static void main(String[] args) {
    SpringApplication.run(SpringReactiveApplication.class, args);
  }

}

@RestController
class SampleController {
  private static final Logger LOG = LoggerFactory.getLogger(SampleController.class);

  @GetMapping(value = "/spring-reactive", produces = MediaType.APPLICATION_JSON_VALUE)
  Mono<ResponseEntity<String>> getRequest(
      @RequestParam("requestId") String requestId,
      @RequestParam(value = "delay", required = false) Long millis) {
    Long delayMillis = Optional.ofNullable(millis).orElse(1000L);
    return Mono.delay(Duration.ofMillis(delayMillis))
        .doOnNext(d -> LOG.info(String.format(
            "simulateDelay = %s from = %s, thread = %s", delayMillis, requestId, Thread.currentThread())))
        .map(d -> ResponseEntity.ok(requestId + System.nanoTime()));
  }

}
