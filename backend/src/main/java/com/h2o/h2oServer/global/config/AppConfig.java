package com.h2o.h2oServer.global.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import static org.springframework.http.HttpMethod.*;

@Configuration
public class AppConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins(
                        "http://localhost:5173",
                        "https://www.h2-cartalog.site",
                        "https://www.h2-cartalog.site:443",
                        "https://h2-cartalog.site",
                        "https://h2-cartalog.site:443"
                )
                .allowedMethods(GET.name(), POST.name(), OPTIONS.name())
                .allowedHeaders("*");
    }
}
