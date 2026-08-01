package com.example.demo.controller;

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
        return "Inicio de pagina me gusta la riata";
    }
}