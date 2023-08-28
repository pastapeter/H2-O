package com.h2o.h2oServer.domain.quotation;

import com.h2o.h2oServer.domain.model_type.dto.ModelTypeIdDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationRequestDto;
import com.h2o.h2oServer.domain.quotation.entity.OptionQuotationEntity;
import com.h2o.h2oServer.domain.quotation.entity.PackageQuotationEntity;
import com.h2o.h2oServer.domain.quotation.entity.ReleaseEntity;

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

    public static ReleaseEntity generateReleaseEntity() {
        return ReleaseEntity.builder()
                .packageCombination("11")
                .optionCombination("8,9,10,11")
                .quotationCount(32)
                .price(10)
                .trimId(5L)
                .externalColorId(1L)
                .internalColorId(3L)
                .drivetrainId(1L)
                .bodytypeId(1L)
                .powertrainId(1L)
                .build();
    }

    public static List<ReleaseEntity> generateReleaseEntityList() {
        return List.of(
                ReleaseEntity.builder()
                        .packageCombination("11,12")
                        .optionCombination("8,9,10")
                        .quotationCount(32)
                        .price(10)
                        .trimId(5L)
                        .externalColorId(1L)
                        .internalColorId(3L)
                        .drivetrainId(1L)
                        .bodytypeId(1L)
                        .powertrainId(1L)
                        .build(),
                ReleaseEntity.builder()
                        .packageCombination("11")
                        .optionCombination("8,9,11")
                        .quotationCount(32)
                        .price(20)
                        .trimId(5L)
                        .externalColorId(1L)
                        .internalColorId(3L)
                        .drivetrainId(1L)
                        .bodytypeId(1L)
                        .powertrainId(1L)
                        .build()
        );
    }

}
