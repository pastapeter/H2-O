package com.h2o.h2oServer;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class H2oServerApplication {

	public static void main(String[] args) {
		SpringApplication.run(H2oServerApplication.class, args);
	}

	@GetMapping("/ping")
	public ResponseEntity ping() {
		return ResponseEntity.ok("pong");
	}
}
