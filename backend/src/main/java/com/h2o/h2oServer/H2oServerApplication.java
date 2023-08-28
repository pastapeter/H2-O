package com.h2o.h2oServer;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
@EnableCaching
public class H2oServerApplication {
	public static void main(String[] args) {
		SpringApplication.run(H2oServerApplication.class, args);
	}

	@GetMapping("/ping")
	public ResponseEntity ping() {
		return ResponseEntity.ok("pong");
	}

	@GetMapping("/redis-ping/{key}")
	@Cacheable(key = "#key", value = "testData", cacheManager = "contentCacheManager")
	public String redisPing(@PathVariable String key) {
		if (key == null) throw new IllegalArgumentException();
		return "cached";
	}
}

