package com.h2o.h2oServer.domain.options.api;

import com.h2o.h2oServer.domain.options.application.OptionsService;
import com.h2o.h2oServer.domain.options.dto.DefaultOptionRangeDto;
import com.h2o.h2oServer.domain.options.dto.OffsetRangeDto;
import com.h2o.h2oServer.domain.options.dto.TrimDefaultOptionDto;
import com.h2o.h2oServer.domain.options.dto.TrimExtraOptionDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@RestController
@RequiredArgsConstructor
@Api(tags = "옵션")
public class OptionsController {

    private final OptionsService optionsService;

    @ApiOperation(value = "트림 추가 옵션 조회", notes = "trim_id를 기준으로 모든 추가 옵션 정보를 반환하는 API")
    @ApiImplicitParam(name = "trimId", value = "트림 인덱스 번호")
    @GetMapping("/trim/{trimId}/extra-option")
    public List<TrimExtraOptionDto> getExtraOptions(@PathVariable Long trimId) {
        List<TrimExtraOptionDto> trimPackages = optionsService.findTrimPackages(trimId);
        List<TrimExtraOptionDto> trimExtraOptions = optionsService.findTrimExtraOptions(trimId);

        return Stream.concat(trimPackages.stream(), trimExtraOptions.stream())
                .collect(Collectors.toList());
    }

    @ApiOperation(value = "트림 기본 옵션 조회", notes = "trim_id를 기준으로 모든 기본 옵션 정보를 반환하는 API")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "trimId", value = "트림 인덱스 번호"),
            @ApiImplicitParam(name = "offset", value = "조회할 기본 옵션의 offset"),
            @ApiImplicitParam(name = "limit", value = "조회할 기본 옵션의 개수")
    })
    @GetMapping("/trim/{trimId}/default-option")
    public List<TrimDefaultOptionDto> getDefaultOptions(@PathVariable Long trimId,
                                                        @RequestParam(required = false) Long from,
                                                        @RequestParam(required = false) Long count) {
        if (from != null && count != null) {
            return optionsService.findTrimDefaultOptions(trimId, DefaultOptionRangeDto.of(from, count));
        }
        return optionsService.findTrimDefaultOptions(trimId);
    }

    @ApiOperation(value = "트림 기본 옵션 offset 범위 조회", notes = "trim_id를 가지는 트림의 기본 옵션의 offset 범위를 반환하는 API")
    @ApiImplicitParam(name = "trimId", value = "트림 인덱스 번호")
    @GetMapping("/trim/{trimId}/default-option/offset-range")
    public OffsetRangeDto getDefaultOptionOffsetRange(@PathVariable Long trimId) {
        return optionsService.findTrimDefaultOptionOffsetRange(trimId);
    }
}
