package com.h2o.h2oServer.domain.optionPackage.mapper;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.optionPackage.entity.PackageEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PackageMapper {
    PackageEntity findPackage(Long trimId, Long packageId);

    List<HashTagEntity> findHashTag(Long id);

    List<Long> findOptionComponent(Long id);

    Boolean checkIfPackageExists(Long id);
}
