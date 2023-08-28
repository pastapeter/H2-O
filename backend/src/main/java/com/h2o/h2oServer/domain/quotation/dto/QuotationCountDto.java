package com.h2o.h2oServer.domain.quotation.dto;

import io.swagger.annotations.ApiModel;
import lombok.Builder;
import lombok.Data;

@ApiModel(value = "견적 출고량 응답")
@Builder
@Data
public class QuotationCountDto {
    private Integer salesCount;
}
