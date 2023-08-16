package com.h2o.h2oServer.domain.quotation.dto;

import com.h2o.h2oServer.domain.model_type.dto.ModelTypeIdDto;
import lombok.Data;

import java.util.List;

@Data
public class QuotationRequestDto {
    private Long carId;
    private Long trimId;
    private ModelTypeIdDto modelTypeIds;
    private Long internalColorId;
    private Long externalColorId;
    private List<Long> optionIds;
    private List<Long> packageIds;
}
