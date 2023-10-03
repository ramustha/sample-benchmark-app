package com.example.springkotlin

import org.slf4j.LoggerFactory
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController

@SpringBootApplication
class SpringKotlinApplication

fun main(args: Array<String>) {
    runApplication<SpringKotlinApplication>(*args)
}

@RestController
class SampleController {

    private val LOG = LoggerFactory.getLogger("SampleController")

    @GetMapping("/spring-kotlin", produces = [MediaType.APPLICATION_JSON_VALUE])
    fun getRequest(
        @RequestParam("requestId") requestId: String,
        @RequestParam("delay", required = false) delay: Long?
    ): ResponseEntity<String> {
        simulateDelay(delay)
        return ResponseEntity.ok(requestId + System.nanoTime())
    }

    fun simulateDelay(millis: Long?) {
        val delayMillis = millis ?: 1000
        LOG.info("simulateDelay = $delayMillis, thread = ${Thread.currentThread()}")
        Thread.sleep(delayMillis)
    }
}
