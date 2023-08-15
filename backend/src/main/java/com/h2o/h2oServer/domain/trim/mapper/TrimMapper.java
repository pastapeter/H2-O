package com.h2o.h2oServer.domain.trim.mapper;

import com.h2o.h2oServer.domain.trim.entity.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TrimMapper {
    TrimEntity findById(Long id);

    List<TrimEntity> findByCarId(Long id);

    List<TrimEntity> findAll();

    List<String> showTables();

    List<ImageEntity> findImages(Long id);

    List<OptionStatisticsEntity> findOptionStatistics(Long id);

    List<InternalColorEntity> findInternalColor(Long id);

    List<ExternalColorEntity> findExternalColor(Long id);

    Integer findMaximumComponentPrice(Long id);
  
    InternalColorEntity findDefaultInternalColor(Long id);

    ExternalColorEntity findDefaultExternalColor(Long id);
}
