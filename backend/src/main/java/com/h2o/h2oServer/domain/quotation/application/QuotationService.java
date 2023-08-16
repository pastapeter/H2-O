package com.h2o.h2oServer.domain.quotation.application;

import com.h2o.h2oServer.domain.quotation.dto.QuotationRequestDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationResponseDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationDto;
import com.h2o.h2oServer.domain.quotation.entity.OptionQuotationEntity;
import com.h2o.h2oServer.domain.quotation.entity.PackageQuotationEntity;
import com.h2o.h2oServer.domain.quotation.mapper.QuotationMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class QuotationService {

    private final QuotationMapper quotationMapper;

    @Transactional
    public QuotationResponseDto saveQuotation(QuotationRequestDto quotationRequestDto) {
        Long quotationId = insertIntoQuotation(quotationRequestDto);

        insertIntoOptionQuotation(quotationRequestDto.getOptionIds(), quotationId);
        insertIntoPackageQuotation(quotationRequestDto.getPackageIds(), quotationId);

        return QuotationResponseDto.of(quotationId);
    }

    private Long insertIntoQuotation(QuotationRequestDto quotationRequestDto) {
        QuotationDto quotationDto = QuotationDto.of(quotationRequestDto);
        quotationMapper.saveQuotation(quotationDto);

        return quotationDto.getId();
    }

    private void insertIntoOptionQuotation(List<Long> optionIds, Long quotationId) {
        OptionQuotationEntity optionQuotationEntity = OptionQuotationEntity.builder()
                .quotationId(quotationId)
                .optionIds(optionIds)
                .build();

        quotationMapper.saveOptionQuotation(optionQuotationEntity);
    }

    private void insertIntoPackageQuotation(List<Long> packageIds, Long quotationId) {
        PackageQuotationEntity packageQuotationEntity = PackageQuotationEntity.builder()
                .quotationId(quotationId)
                .packageIds(packageIds)
                .build();

        quotationMapper.savePackageQuotation(packageQuotationEntity);
    }
}
