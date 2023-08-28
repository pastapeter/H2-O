package com.h2o.h2oServer.domain.option.application;

import com.h2o.h2oServer.domain.option.dto.OptionDetailsDto;
import com.h2o.h2oServer.domain.option.dto.OptionDto;
import com.h2o.h2oServer.domain.option.dto.TrimDefaultOptionDto;
import com.h2o.h2oServer.domain.option.dto.TrimExtraOptionDto;
import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.OptionDetailsEntity;
import com.h2o.h2oServer.domain.option.entity.OptionEntity;
import com.h2o.h2oServer.domain.option.exception.NoSuchOptionException;
import com.h2o.h2oServer.domain.option.mapper.OptionMapper;
import com.h2o.h2oServer.domain.optionPackage.mapper.PackageMapper;
import com.h2o.h2oServer.domain.option.entity.TrimDefaultOptionEntity;
import com.h2o.h2oServer.domain.option.entity.TrimExtraOptionEntity;
import com.h2o.h2oServer.global.util.Validator;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OptionService {

    private final OptionMapper optionMapper;
    private final PackageMapper packageMapper;

    public OptionDetailsDto findDetailedOptionInformation(Long optionId, Long trimId) {
        OptionDetailsEntity optionDetailsEntity = optionMapper.findOptionDetails(optionId, trimId)
                .orElseThrow(NoSuchOptionException::new);

        List<HashTagEntity> hashTagEntities = optionMapper.findHashTag(optionId);

        return OptionDetailsDto.of(optionDetailsEntity, hashTagEntities);
    }

    public OptionDto findOptionInformation(Long optionId) {
        OptionEntity optionEntity = optionMapper.findOption(optionId).orElseThrow(NoSuchOptionException::new);

        List<HashTagEntity> hashTagEntities = optionMapper.findHashTag(optionId);

        return OptionDto.of(optionEntity, hashTagEntities);
    }

    public List<TrimExtraOptionDto> findTrimPackages(Long trimId) {
        List<TrimExtraOptionEntity> extraOptionEntities = optionMapper.findTrimPackages(trimId);
        Validator.validateExistenceOfOptions(extraOptionEntities);
        
        return convertPackageEntityToDto(extraOptionEntities);
    }

    public List<TrimExtraOptionDto> findTrimExtraOptions(Long trimId) {
        List<TrimExtraOptionEntity> extraOptionEntities = optionMapper.findTrimExtraOptions(trimId);
        Validator.validateExistenceOfOptions(extraOptionEntities);
        return convertExtraOptionEntityToDto(extraOptionEntities);
    }

    public List<TrimDefaultOptionDto> findTrimDefaultOptions(Long trimId) {
        List<TrimDefaultOptionEntity> defaultOptionEntities = optionMapper.findTrimDefaultOptions(trimId);
        Validator.validateExistenceOfOptions(defaultOptionEntities);
        return convertDefaultOptionToDto(defaultOptionEntities);
    }

    private List<TrimExtraOptionDto> convertPackageEntityToDto(List<TrimExtraOptionEntity> extraOptionEntities) {
        return extraOptionEntities.stream()
                .map(extraOptionEntity -> {
                    List<HashTagEntity> packageHashTags = packageMapper.findHashTag(extraOptionEntity.getId());
                    return TrimExtraOptionDto.of(true, extraOptionEntity, packageHashTags);
                })
                .collect(Collectors.toList());
    }

    private List<TrimExtraOptionDto> convertExtraOptionEntityToDto(List<TrimExtraOptionEntity> extraOptionEntities) {
        return extraOptionEntities.stream()
                .map(extraOptionEntity -> {
                    List<HashTagEntity> packageHashTags = optionMapper.findHashTag(extraOptionEntity.getId());
                    return TrimExtraOptionDto.of(false, extraOptionEntity, packageHashTags);
                })
                .collect(Collectors.toList());
    }

    private List<TrimDefaultOptionDto> convertDefaultOptionToDto(List<TrimDefaultOptionEntity> defaultOptionEntities) {
        return defaultOptionEntities.stream()
                .map(defaultOptionEntity -> {
                    List<HashTagEntity> optionHashTags = optionMapper.findHashTag(defaultOptionEntity.getId());
                    return TrimDefaultOptionDto.of(defaultOptionEntity, optionHashTags);
                })
                .collect(Collectors.toList());
    }
}
