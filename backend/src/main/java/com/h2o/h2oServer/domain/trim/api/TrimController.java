package com.h2o.h2oServer.domain.trim.api;

import com.h2o.h2oServer.domain.trim.application.TrimService;
import com.h2o.h2oServer.domain.trim.dto.DefaultTrimCompositionDto;
import com.h2o.h2oServer.domain.trim.dto.ExternalColorDto;
import com.h2o.h2oServer.domain.trim.dto.InternalColorDto;
import com.h2o.h2oServer.domain.trim.dto.PriceRangeDto;
import com.h2o.h2oServer.domain.trim.dto.TrimDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@Api(tags = "트림")
public class TrimController {

    private final TrimService trimService;

    @ApiOperation(value = "차량의 트림 정보 조회", notes = "car_id를 기준으로 모든 트림 정보를 반환하는 API")
    @ApiImplicitParam(name = "carId", value = "차종 인덱스 번호")
    @GetMapping("car/{carId}/trim")
    public List<TrimDto> getTrimInformation(@PathVariable Long carId) {
        return trimService.findTrimInformation(carId);
    }

    @ApiOperation(value = "트림의 외부 색상 정보 조회", notes = "trim_id를 기준으로 모든 외부 색상 정보를 반환하는 API")
    @ApiImplicitParam(name = "trimId", value = "트림 인덱스 번호")
    @GetMapping("trim/{trimId}/external-color")
    public List<ExternalColorDto> getExternalColorInformation(@PathVariable Long trimId) {
        return trimService.findExternalColorInformation(trimId);
    }

    @ApiOperation(value = "트림의 내부 색상 정보 조회", notes = "trim_id를 기준으로 모든 내부 색상 정보를 반환하는 API")
    @ApiImplicitParam(name = "trimId", value = "트림 인덱스 번호")
    @GetMapping("/trim/{trimId}/internal-color")
    public List<InternalColorDto> getInternalColorInformation(@PathVariable Long trimId) {
        return trimService.findInternalColorInformation(trimId);
    }

    @ApiOperation(value = "트림의 기본 구성 정보 조회", notes = "구성을 선택하지 않았을 경우의 기본적인 모델타입, 색상 구성을 반환하는 API")
    @ApiImplicitParam(name = "trimId", value = "트림 인덱스 번호")
    @GetMapping("/trim/{trimId}/default-composition")
    public DefaultTrimCompositionDto getDefaultTrimComposition(@PathVariable Long trimId) {
        return trimService.findDefaultComposition(trimId);
    }

    @GetMapping("/trim/{trimId}/price-range")
    public PriceRangeDto getPriceRange(@PathVariable Long trimId) {
        return trimService.findPriceRange(trimId);
    }
}
