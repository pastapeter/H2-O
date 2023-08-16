package com.h2o.h2oServer.domain.quotation.dto;

import lombok.Data;

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
