package com.h2o.h2oServer.domain.optionPackage.application;

import com.h2o.h2oServer.domain.option.application.OptionService;
import com.h2o.h2oServer.domain.option.dto.OptionDetailsDto;
import com.h2o.h2oServer.domain.option.dto.OptionDto;
import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.optionPackage.dto.PackageDetailsDto;
import com.h2o.h2oServer.domain.optionPackage.entity.PackageEntity;
import com.h2o.h2oServer.domain.optionPackage.mapper.PackageMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PackageService {
    private final PackageMapper packageMapper;
    private final OptionService optionService;

    public PackageDetailsDto findPackageInformation(Long trimId, Long packageId) {
        PackageEntity packageEntity = packageMapper.findPackage(trimId, packageId);
        List<HashTagEntity> hashTagEntities = packageMapper.findHashTag(packageId);
        List<Long> optionComponentsIds = packageMapper.findOptionComponent(packageId);

        List<OptionDto> optionDtos = optionComponentsIds.stream()
                .map(optionId -> optionService.findOptionInformation(optionId))
                .collect(Collectors.toList());

        return PackageDetailsDto.of(packageEntity, hashTagEntities, optionDtos);
    }
}
