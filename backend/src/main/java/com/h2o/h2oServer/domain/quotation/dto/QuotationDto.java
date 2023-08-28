package com.h2o.h2oServer.domain.quotation.dto;

import lombok.Data;

import java.io.Serializable;

@Data
public class QuotationDto implements Serializable {
    private Long id;
    private Long carId;
    private Long trimId;
    private Long powertrainId;
    private Long bodytypeId;
    private Long drivetrainId;
    private Long internalColorId;
    private Long externalColorId;

    public QuotationDto(Long carId, Long trimId, Long powertrainId,
                        Long bodytypeId, Long drivetrainId, Long internalColorId,
                        Long externalColorId) {
        this.carId = carId;
        this.trimId = trimId;
        this.powertrainId = powertrainId;
        this.bodytypeId = bodytypeId;
        this.drivetrainId = drivetrainId;
        this.internalColorId = internalColorId;
        this.externalColorId = externalColorId;
    }

    public static QuotationDto of(QuotationRequestDto quotationRequestDto) {
        return new QuotationDto(
                quotationRequestDto.getCarId(),
                quotationRequestDto.getTrimId(),
                quotationRequestDto.getModelTypeIds().getPowertrainId(),
                quotationRequestDto.getModelTypeIds().getBodytypeId(),
                quotationRequestDto.getModelTypeIds().getDrivetrainId(),
                quotationRequestDto.getInternalColorId(),
                quotationRequestDto.getExternalColorId()
        );
    }
}
