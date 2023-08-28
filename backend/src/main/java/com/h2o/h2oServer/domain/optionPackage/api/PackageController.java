package com.h2o.h2oServer.domain.optionPackage.api;

import com.h2o.h2oServer.domain.optionPackage.application.PackageService;
import com.h2o.h2oServer.domain.optionPackage.dto.PackageDetailsDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@Api(tags = "옵션")
public class PackageController {
    private final PackageService packageService;

    @ApiOperation(value = "패키지 세부 정보 조회", notes = "trim_id, package_id를 기준으로 패키지의 세부 정보를 반환하는 API")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "trimId", value = "트림 인덱스 번호"),
            @ApiImplicitParam(name = "packageId", value = "패키지 인덱스 번호")
    })
    @GetMapping("trim/{trimId}/package/{packageId}")
    @Cacheable(value = "packageDetail", cacheManager = "contentCacheManager")
    public PackageDetailsDto getPackageInformation(@PathVariable Long trimId, @PathVariable Long packageId) {
        return packageService.findPackageInformation(trimId, packageId);
    }
}
