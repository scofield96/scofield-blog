package com.scofield.blog;


import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan("com.scofield.blog.dao")
@SpringBootApplication
public class ScofieldBlogApplication {
    public static void main(String[] args) {

        SpringApplication.run(ScofieldBlogApplication.class,args);

    }
}
