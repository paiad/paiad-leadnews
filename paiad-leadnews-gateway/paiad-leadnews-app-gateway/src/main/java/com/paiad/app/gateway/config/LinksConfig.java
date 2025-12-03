package com.paiad.app.gateway.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
@ConfigurationProperties(prefix = "app.links")
public class LinksConfig {

    private Map<String, LinkInfo> links;

    public static class LinkInfo {
        private String name;
        private String url;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }

        @Override
        public String toString() {
            return name + ": " + url;
        }
    }

    public Map<String, LinkInfo> getLinks() {
        return links;
    }

    public void setLinks(Map<String, LinkInfo> links) {
        this.links = links;
    }
}