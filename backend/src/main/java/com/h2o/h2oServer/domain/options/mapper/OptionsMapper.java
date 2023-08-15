package com.h2o.h2oServer.domain.options.mapper;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.options.entity.TrimDefaultOptionEntity;
import com.h2o.h2oServer.domain.options.entity.TrimExtraOptionEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OptionsMapper {
    List<TrimExtraOptionEntity> findTrimPackages(Long trimId);
    List<TrimExtraOptionEntity> findTrimExtraOptions(Long trimId);
    List<TrimDefaultOptionEntity> findTrimDefaultOptions(Long trimId);
    List<HashTagEntity> findPackageHashTags(Long packageId);
    List<HashTagEntity> findOptionHashTag(Long optionId);
}
