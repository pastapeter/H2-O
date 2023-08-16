package com.h2o.h2oServer.domain.quotation.api;

import com.h2o.h2oServer.domain.quotation.application.QuotationService;
import com.h2o.h2oServer.domain.quotation.dto.QuotationResponseDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class QuotationController {

    private final QuotationService quotationService;

    @PostMapping("/quotation")
    public ResponseEntity<QuotationResponseDto> saveQuotation(@RequestBody QuotationRequestDto quotationRequestDto) {
        QuotationResponseDto quotationResponseDto = quotationService.saveQuotation(quotationRequestDto);
        return new ResponseEntity<>(quotationResponseDto, HttpStatus.CREATED);
    }
}
