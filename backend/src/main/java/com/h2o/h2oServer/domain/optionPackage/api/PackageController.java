package com.h2o.h2oServer.domain.optionPackage.api;

import com.h2o.h2oServer.domain.optionPackage.application.PackageService;
import com.h2o.h2oServer.domain.optionPackage.dto.PackageDetailsDto;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class PackageController {
    private final PackageService packageService;

    @GetMapping("trim/{trimId}/package/{packageId}")
    public PackageDetailsDto getPackageInformation(@PathVariable Long trimId, @PathVariable Long packageId) {
        return packageService.findPackageInformation(trimId, packageId);
    }
}
