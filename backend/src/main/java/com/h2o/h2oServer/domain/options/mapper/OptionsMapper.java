package com.h2o.h2oServer.domain.options.mapper;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.options.entity.TrimOptionEntity;
import com.h2o.h2oServer.domain.options.entity.enums.OptionType;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OptionsMapper {
    List<TrimOptionEntity> findTrimPackages(Long trimId);
    List<TrimOptionEntity> findTrimOptions(@Param("trimId") Long trimId, @Param("optionType") OptionType optionType);
    List<HashTagEntity> findPackageHashTags(Long packageId);
    List<HashTagEntity> findOptionHashTag(Long optionId);
}
