package com.example.demo.config;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.core.MongoTemplate;

@Configuration
public class MongoConfig {

    private static final String MONGODB_URI = "mongodb+srv://campitos:perrito@puto1.thlww56.mongodb.net/farma?appName=Puto1";

    @Bean
    public MongoClient mongoClient() {
        return MongoClients.create(MONGODB_URI);
    }

    @Bean
    public MongoTemplate mongoTemplate() {
        return new MongoTemplate(mongoClient(), "farma");
    }
}