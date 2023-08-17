package com.h2o.h2oServer.domain.option.mapper;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.OptionDetailsEntity;
import com.h2o.h2oServer.domain.option.entity.OptionEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OptionMapper {
    OptionDetailsEntity findOptionDetails(Long id, Long trimId);

    OptionEntity findOption(Long id);

    List<HashTagEntity> findHashTag(Long id);

    Boolean checkIfOptionExists(Long id);
}
