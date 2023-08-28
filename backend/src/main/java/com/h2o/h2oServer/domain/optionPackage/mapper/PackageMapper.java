package com.h2o.h2oServer.domain.optionPackage.mapper;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.optionPackage.entity.PackageEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;

@Mapper
public interface PackageMapper {
    Optional<PackageEntity> findPackage(@Param("trimId") Long trimId, @Param("packageId") Long packageId);

    List<HashTagEntity> findHashTag(Long id);

    List<Long> findOptionComponent(Long id);

    Boolean checkIfPackageExists(Long id);
}
