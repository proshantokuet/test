package org.opensrp.web.rest.controller;

import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.nio.file.Files;

@RequestMapping("/api")
@RestController
public class AnalyticsRestController {

    @RequestMapping("/division-geojson")
    public String getDivisionGeoJson() {
        String geoJson = "";
        try {
            File file = ResourceUtils.getFile("classpath:leaflet/division.json");
            geoJson = new String(Files.readAllBytes(file.toPath()));
        } catch (Exception ex) {}

        return geoJson;
    }
}
