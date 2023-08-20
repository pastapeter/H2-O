package com.h2o.h2oServer.domain.options.mapper;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.options.dto.PageRangeDto;
import com.h2o.h2oServer.domain.options.entity.TrimDefaultOptionEntity;
import com.h2o.h2oServer.domain.options.entity.TrimExtraOptionEntity;
import com.h2o.h2oServer.domain.options.enums.OptionType;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OptionsMapper {
    List<TrimExtraOptionEntity> findTrimPackages(Long trimId);

    List<TrimExtraOptionEntity> findTrimPackagesWithRange(@Param("trimId") Long trimId,
                                                          @Param("pageRange") PageRangeDto pageRange);

    List<TrimExtraOptionEntity> findTrimExtraOptions(Long trimId);

    List<TrimExtraOptionEntity> findTrimExtraOptionsWithRange(@Param("trimId") Long trimId,
                                                              @Param("pageRange") PageRangeDto pageRange);

    List<TrimDefaultOptionEntity> findTrimDefaultOptions(Long trimId);

    List<TrimDefaultOptionEntity> findTrimDefaultOptionsWithRange(@Param("trimId") Long trimId,
                                                                  @Param("pageRange") PageRangeDto pageRange);

    List<HashTagEntity> findPackageHashTags(Long packageId);

    List<HashTagEntity> findOptionHashTag(Long optionId);

    Long findTrimPackageSize(Long trimId);

    Long findTrimOptionSize(@Param("trimId") Long trimId, @Param("optionType") OptionType optionType);
}
