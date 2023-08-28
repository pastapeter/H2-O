package com.h2o.h2oServer.domain.trim.mapper;

import com.h2o.h2oServer.domain.trim.entity.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;

@Mapper
public interface TrimMapper {
    Optional<TrimEntity> findById(Long id);

    List<TrimEntity> findByCarId(Long id);

    List<TrimEntity> findAll();

    List<ImageEntity> findImages(Long id);

    List<OptionStatisticsEntity> findOptionStatistics(Long id);

    List<InternalColorEntity> findInternalColor(Long id);

    List<ExternalColorEntity> findExternalColor(Long id);

    Integer findMaximumComponentPrice(Long id);

    InternalColorEntity findDefaultInternalColor(Long id);

    ExternalColorEntity findDefaultExternalColor(Long id);

    Boolean checkIfTrimExists(Long id);

    Integer findQuantityBetween(@Param("id") Long id, @Param("from") Integer from, @Param("to") Integer to);
}
