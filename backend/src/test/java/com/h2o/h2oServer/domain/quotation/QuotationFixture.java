package com.h2o.h2oServer.domain.quotation;

import com.h2o.h2oServer.domain.model_type.dto.ModelTypeIdDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationRequestDto;

import java.util.List;

public class QuotationFixture {
    public static QuotationRequestDto generateQuotationRequestDto() {
        return QuotationRequestDto.builder()
                .carId(4L)
                .trimId(5L)
                .modelTypeIds(ModelTypeIdDto.builder()
                        .bodytypeId(2L)
                        .drivetrainId(3L)
                        .powertrainId(1L)
                        .build())
                .externalColorId(7L)
                .internalColorId(6L)
                .optionIds(List.of(8L, 9L, 10L))
                .packageIds(List.of(11L))
                .build();
    }
}
