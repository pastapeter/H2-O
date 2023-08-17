package com.h2o.h2oServer.domain.model_type.mapper;

import com.h2o.h2oServer.domain.model_type.Entity.TechnicalSpecEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface TechnicalSpecMapper {
    TechnicalSpecEntity findSpec(@Param("powertrainId") Long powertrainId, @Param("drivetrainId") Long drivetrainId);

    Boolean checkIfTechnicalSpecExists(Long powertrainId, Long drivetrainId);
}
