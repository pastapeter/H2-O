package com.h2o.h2oServer.domain.quotation.mapper;

import com.h2o.h2oServer.domain.quotation.dto.QuotationDto;
import com.h2o.h2oServer.domain.quotation.entity.OptionQuotationEntity;
import com.h2o.h2oServer.domain.quotation.entity.PackageQuotationEntity;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QuotationMapper {
    void saveQuotation(QuotationDto quotationDTO);
    void saveOptionQuotation(OptionQuotationEntity optionQuotationEntity);
    void savePackageQuotation(PackageQuotationEntity packageQuotationEntity);
    long countQuotation();
    long countOptionQuotation();
    long countPackageQuotation();
}
