package com.h2o.h2oServer.domain.option.api;

import com.h2o.h2oServer.domain.option.application.OptionService;
import com.h2o.h2oServer.domain.option.dto.OptionDetailsDto;
import com.h2o.h2oServer.domain.option.dto.TrimDefaultOptionDto;
import com.h2o.h2oServer.domain.option.dto.TrimExtraOptionDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequiredArgsConstructor
@Api(tags = "옵션")
public class OptionController {
    private final OptionService optionService;

    @ApiOperation(value = "옵션 세부 정보 조회", notes = "trim_id, option_id를 기준으로 옵션의 세부 정보를 반환하는 API")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "trimId", value = "트림 인덱스 번호"),
            @ApiImplicitParam(name = "optionId", value = "옵션 인덱스 번호")
    })
    @Cacheable(value = "optionDetail", cacheManager = "contentCacheManager")
    @GetMapping("/trim/{trimId}/option/{optionId}")
    public OptionDetailsDto getOptionInformation(@PathVariable Long trimId, @PathVariable Long optionId) {
        return optionService.findDetailedOptionInformation(optionId, trimId);
    }

    @ApiOperation(value = "트림 추가 옵션 조회", notes = "trim_id를 기준으로 추가 옵션 정보를 반환하는 API")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "trimId", value = "트림 인덱스 번호")
    })
    @Cacheable(key = "#trimId", value = "extraOptions", cacheManager = "contentCacheManager")
    @GetMapping("/trim/{trimId}/extra-option")
    public List<TrimExtraOptionDto> getExtraOptions(@PathVariable Long trimId) {
        List<TrimExtraOptionDto> trimExtraOptionDtos = new ArrayList<>();
        trimExtraOptionDtos.addAll(optionService.findTrimPackages(trimId));
        trimExtraOptionDtos.addAll(optionService.findTrimExtraOptions(trimId));
        return trimExtraOptionDtos;
    }

    @ApiOperation(value = "트림 기본 옵션 조회", notes = "trim_id를 기준으로 기본 옵션 정보를 반환하는 API")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "trimId", value = "트림 인덱스 번호")
    })
    @Cacheable(key = "#trimId", value = "defaultOptions", cacheManager = "contentCacheManager")
    @GetMapping("/trim/{trimId}/default-option")
    public List<TrimDefaultOptionDto> getDefaultOptions(@PathVariable Long trimId) {
        return optionService.findTrimDefaultOptions(trimId);
    }
}
