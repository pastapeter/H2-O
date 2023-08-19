package com.h2o.h2oServer.domain.quotation.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

@ApiModel(value = "견적 저장 요청 응답")
@Data
public class QuotationResponseDto {
    private Long quotationId;

    private QuotationResponseDto(Long quotationId) {
        this.quotationId = quotationId;
    }

    public static QuotationResponseDto of(Long quotationId) {
        return new QuotationResponseDto(quotationId);
    }
}
