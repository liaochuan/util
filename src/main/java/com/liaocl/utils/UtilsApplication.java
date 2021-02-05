package com.liaocl.utils;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author liaocl
 */
@RestController
@SpringBootApplication
public class UtilsApplication {
	
	public static void main(String[] args) {
		SpringApplication.run(UtilsApplication.class, args);
	}
	
    @RequestMapping("/")
    public String index() {
        return "hello spring boot1";
    }

}
