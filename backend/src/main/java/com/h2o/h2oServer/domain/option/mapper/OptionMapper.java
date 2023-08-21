package com.h2o.h2oServer.domain.option.mapper;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.OptionDetailsEntity;
import com.h2o.h2oServer.domain.option.entity.OptionEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;

@Mapper
public interface OptionMapper {
    Optional<OptionDetailsEntity> findOptionDetails(@Param("id") Long id, @Param("trimId") Long trimId);

    Optional<OptionEntity> findOption(Long id);

    List<HashTagEntity> findHashTag(Long id);

    Boolean checkIfOptionExists(Long id);
}
