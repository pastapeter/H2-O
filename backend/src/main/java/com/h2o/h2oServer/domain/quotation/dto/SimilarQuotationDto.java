package com.h2o.h2oServer.domain.quotation.dto;

import com.h2o.h2oServer.domain.model_type.dto.ModelTypeNameDto;
import com.h2o.h2oServer.domain.option.dto.OptionSummaryDto;
import io.swagger.annotations.ApiModel;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@ApiModel(value = "유사 견적 정보 조회 응답")
@Data
@Builder
public class SimilarQuotationDto {
    private ModelTypeNameDto modelType;
    private Integer salesCount;
    private String image;
    private Integer price;
    private List<OptionSummaryDto> options;

    public static SimilarQuotationDto of(ModelTypeNameDto modelTypeNameDto,
                                         String image,
                                         Integer price,
                                         Integer salesCount,
                                         List<OptionSummaryDto> options) {
        return SimilarQuotationDto.builder()
                .modelType(modelTypeNameDto)
                .image(image)
                .price(price)
                .salesCount(salesCount)
                .options(options)
                .build();
    }
}
