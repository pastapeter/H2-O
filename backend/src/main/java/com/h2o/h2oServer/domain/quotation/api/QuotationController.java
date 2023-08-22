package com.h2o.h2oServer.domain.quotation.api;

import com.h2o.h2oServer.domain.quotation.application.QuotationService;
import com.h2o.h2oServer.domain.quotation.dto.QuotationCountDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationResponseDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationRequestDto;
import com.h2o.h2oServer.domain.quotation.dto.SimilarQuotationDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/quotation")
@RequiredArgsConstructor
@Api(tags = "견적")
public class QuotationController {
    private final QuotationService quotationService;

    @ApiOperation(value = "견적 정보 저장", notes = "견적 정보를 저장하는 API")
    @ApiImplicitParam(name = "quotationRequestDto", value = "저장할 견적 정보")
    @PostMapping
    public ResponseEntity<QuotationResponseDto> saveQuotation(@RequestBody QuotationRequestDto quotationRequestDto) {
        QuotationResponseDto quotationResponseDto = quotationService.saveQuotation(quotationRequestDto);
        return new ResponseEntity<>(quotationResponseDto, HttpStatus.CREATED);
    }

    @ApiOperation(value = "유사 견적 조회", notes = "유사 견적 정보를 반환하는 API")
    @ApiImplicitParam(name = "quotationRequestDto", value = "비교할 견적 정보")
    @PostMapping("/similar")
    public List<SimilarQuotationDto> getSimilarQuotations(@RequestBody QuotationRequestDto quotationRequestDto) {

        return quotationService.findSimilarQuotations(quotationRequestDto);
    }

    @ApiOperation(value = "동일한 견적 수 조회", notes = "동일한 출고 견적 출고량을 반환하는  API")
    @ApiImplicitParam(name = "quotationRequestDto", value = "비교할 견적 정보")
    @PostMapping("/sales")
    public QuotationCountDto getSalesOfIdenticalQuotation(@RequestBody QuotationRequestDto quotationRequestDto) {
        return quotationService.findNumberOfIdenticalQuotations(quotationRequestDto);
    }
}
