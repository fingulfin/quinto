package com.example.demo.controller;

import com.example.demo.model.User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/hello")
    public String hello() {
        return "Desesperado";
    }
    @GetMapping("/")
    public String bienvenida() {
        return "Proyecto hospedado en google cloud run esto es muy niceeeee ddd";
    }
    @GetMapping("/fake")
    public User fakeUser() {
        return new User("Fake User", "fake@example.com");
    }
}