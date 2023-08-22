package com.h2o.h2oServer.domain.quotation.mapper;

import com.h2o.h2oServer.domain.quotation.dto.QuotationDto;
import com.h2o.h2oServer.domain.quotation.entity.OptionQuotationEntity;
import com.h2o.h2oServer.domain.quotation.entity.PackageQuotationEntity;

import com.h2o.h2oServer.domain.quotation.entity.ReleaseEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface QuotationMapper {
    void saveQuotation(QuotationDto quotationDTO);

    void saveOptionQuotation(OptionQuotationEntity optionQuotationEntity);

    void savePackageQuotation(PackageQuotationEntity packageQuotationEntity);

    long countQuotation();

    long countOptionQuotation();

    long countPackageQuotation();

    List<ReleaseEntity> findReleaseQuotationWithVolume(Long trimId);

    Integer countIdenticalQuotation(QuotationDto quotationDto,
                                     String optionCombination,
                                     String packageCombination);

    List<String> findIdenticalQuotations(QuotationDto quotationDto,
                 String optionCombination,
                 String packageCombination);
}
