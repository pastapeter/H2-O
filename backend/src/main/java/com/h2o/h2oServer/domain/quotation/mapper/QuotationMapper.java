package com.h2o.h2oServer.domain.quotation.mapper;

import com.h2o.h2oServer.domain.quotation.dto.QuotationDto;
import com.h2o.h2oServer.domain.quotation.entity.OptionQuotationEntity;
import com.h2o.h2oServer.domain.quotation.entity.PackageQuotationEntity;

import com.h2o.h2oServer.domain.quotation.entity.ReleaseEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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

    Integer countIdenticalQuotation(@Param("quotationDto") QuotationDto quotationDto,
                                    @Param("optionCombination") String optionCombination,
                                    @Param("packageCombination") String packageCombination);

    List<String> findIdenticalQuotations(@Param("quotationDto") QuotationDto quotationDto,
                                         @Param("optionCombination") String optionCombination,
                                         @Param("packageCombination") String packageCombination);
}
