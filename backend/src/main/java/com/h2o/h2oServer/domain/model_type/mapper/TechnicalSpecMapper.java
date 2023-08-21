package com.h2o.h2oServer.domain.model_type.mapper;

import com.h2o.h2oServer.domain.model_type.Entity.TechnicalSpecEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Optional;

@Mapper
public interface TechnicalSpecMapper {
    Optional<TechnicalSpecEntity> findSpec(@Param("powertrainId") Long powertrainId,
                                           @Param("drivetrainId") Long drivetrainId);

    Boolean checkIfTechnicalSpecExists(@Param("powertrainId") Long powertrainId,
                                       @Param("drivetrainId") Long drivetrainId);
}
