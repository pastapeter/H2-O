package com.h2o.h2oServer.domain.options.api;

import com.h2o.h2oServer.domain.options.application.OptionsService;
import com.h2o.h2oServer.domain.options.dto.TrimDefaultOptionDto;
import com.h2o.h2oServer.domain.options.dto.TrimExtraOptionDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
    @ApiImplicitParam(name = "trimId", value = "트림 인덱스 번호")
    @GetMapping("/trim/{trimId}/default-option")
    public List<TrimDefaultOptionDto> getDefaultOptions(@PathVariable Long trimId) {
        return optionsService.findTrimDefaultOptions(trimId);
    }
}
