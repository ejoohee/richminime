package com.richminime;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class RichMinimeApplication {

	public static void main(String[] args) {
		SpringApplication.run(RichMinimeApplication.class, args);
	}

}
