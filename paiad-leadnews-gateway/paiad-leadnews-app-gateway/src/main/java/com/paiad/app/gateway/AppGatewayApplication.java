package com.paiad.app.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

import java.util.Arrays;
import java.util.List;


@SpringBootApplication
@EnableDiscoveryClient
public class AppGatewayApplication {

    public static void main(String[] args) {
        SpringApplication.run(AppGatewayApplication.class,args);

        // print links
        printUsefulLinks();
    }

    private static void printUsefulLinks() {
        System.out.println("\n===============================================");
        System.out.println("      Paiad Leadnews Starting ~   ");
        System.out.println("===============================================");

        List<String> usefulLinks = Arrays.asList(
            "Front: http://localhost:8801/#/home",
            "Nacos: http://localhost:8848/nacos",
            "MinIO: http://localhost:9090/\n",
            "User: http://localhost:51801/doc.html",
            "Article: http://localhost:51802/doc.html"
        );

        System.out.println("Link List:");
        usefulLinks.forEach(link -> System.out.println("  - " + link));

        System.out.println("===============================================\n");
    }
}
