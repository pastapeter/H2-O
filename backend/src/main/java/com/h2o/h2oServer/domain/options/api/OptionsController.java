package com.h2o.h2oServer.domain.options.api;

import com.h2o.h2oServer.domain.options.application.OptionsService;
import com.h2o.h2oServer.domain.options.dto.*;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequiredArgsConstructor
@Api(tags = "옵션")
public class OptionsController {

    private final OptionsService optionsService;

    @ApiOperation(value = "트림 추가 옵션 조회", notes = "trim_id를 기준으로 추가 옵션 정보를 반환하는 API")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "trimId", value = "트림 인덱스 번호"),
            @ApiImplicitParam(name = "fromPackage", value = "[페이징] 조회할 패키지의 시작 위치"),
            @ApiImplicitParam(name = "countPackage", value = "[페이징] 조회할 패키지의 개수"),
            @ApiImplicitParam(name = "fromOption", value = "[페이징] 조회할 추가 옵션의 시작 위치"),
            @ApiImplicitParam(name = "countOption", value = "[페이징] 조회할 추가 옵션의 개수")
    })
    @Cacheable(key = "#trimId", value = "extraOptions", cacheManager = "contentCacheManager")
    @GetMapping("/trim/{trimId}/extra-option")
    public List<TrimExtraOptionDto> getExtraOptions(@PathVariable Long trimId,
                                                    @RequestParam(required = false) Long fromPackage,
                                                    @RequestParam(required = false) Long countPackage,
                                                    @RequestParam(required = false) Long fromOption,
                                                    @RequestParam(required = false) Long countOption) {
        List<TrimExtraOptionDto> trimExtraOptionDtos = new ArrayList<>();

        // 범위 지정 X -> 추가 옵션 모두 불러오기
        if (!haveValues(fromPackage, countPackage, fromOption, countOption)) {
            trimExtraOptionDtos.addAll(optionsService.findTrimPackages(trimId));
            trimExtraOptionDtos.addAll(optionsService.findTrimExtraOptions(trimId));
        }
        // 범위 지정 O -> 지정된 범위만큼 [옵션 + 패키지] 불러오기
        else {
            // 불러올 패키지의 범위가 지정되어 있을 때
            if (haveValues(fromPackage, countPackage)) {
                trimExtraOptionDtos.addAll(
                        optionsService.findTrimPackages(trimId, PageRangeDto.of(fromPackage, countPackage))
                );
            }
            // 불러올 옵션의 범위가 지정되어 있을 때
            if (haveValues(fromOption, countOption)) {
                trimExtraOptionDtos.addAll(
                        optionsService.findTrimExtraOptions(trimId, PageRangeDto.of(fromOption, countOption))
                );
            }
        }

        return trimExtraOptionDtos;
    }

    @ApiOperation(value = "트림 기본 옵션 조회", notes = "trim_id를 기준으로 기본 옵션 정보를 반환하는 API")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "trimId", value = "트림 인덱스 번호"),
            @ApiImplicitParam(name = "from", value = "[페이징] 조회할 기본 옵션의 시작 위치"),
            @ApiImplicitParam(name = "count", value = "[페이징] 조회할 기본 옵션의 개수")
    })
    @Cacheable(key = "#trimId", value = "defaultOptions", cacheManager = "contentCacheManager")
    @GetMapping("/trim/{trimId}/default-option")
    public List<TrimDefaultOptionDto> getDefaultOptions(@PathVariable Long trimId,
                                                        @RequestParam(required = false) Long from,
                                                        @RequestParam(required = false) Long count) {
        if (from != null && count != null) {
            return optionsService.findTrimDefaultOptions(trimId, PageRangeDto.of(from, count));
        }
        return optionsService.findTrimDefaultOptions(trimId);
    }

    @ApiOperation(value = "트림 추가 옵션 offset 범위 조회", notes = "trim_id를 가지는 트림의 추가 옵션의 시작 인덱스와 개수를 반환하는 API")
    @ApiImplicitParam(name = "trimId", value = "트림 인덱스 번호")
    @GetMapping("/trim/{trimId}/extra-option/size")
    public ExtraOptionSizeDto getExtraOptionSize(@PathVariable Long trimId) {
        return optionsService.findTrimExtraOptionSize(trimId);
    }

    @ApiOperation(value = "트림 기본 옵션 offset 범위 조회", notes = "trim_id를 가지는 트림의 기본 옵션의 시작 인덱스와 개수를 반환하는 API")
    @ApiImplicitParam(name = "trimId", value = "트림 인덱스 번호")
    @GetMapping("/trim/{trimId}/default-option/size")
    public DefaultOptionSizeDto getDefaultOptionSize(@PathVariable Long trimId) {
        return optionsService.findTrimDefaultOptionSize(trimId);
    }

    private boolean haveValues(Long... parameters) {
        for (Long parameter : parameters) {
            if (parameter != null) {
                return true;
            }
        }
        return false;
    }
}
