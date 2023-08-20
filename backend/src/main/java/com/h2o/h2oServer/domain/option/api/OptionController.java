package com.h2o.h2oServer.domain.option.api;

import com.h2o.h2oServer.domain.option.application.OptionService;
import com.h2o.h2oServer.domain.option.dto.OptionDetailsDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

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
    @GetMapping("/trim/{trimId}/option/{optionId}")
    public OptionDetailsDto getOptionInformation(@PathVariable Long trimId, @PathVariable Long optionId) {
        OptionDetailsDto optionInformation = optionService.findDetailedOptionInformation(optionId, trimId);
        return optionInformation;
    }
}
