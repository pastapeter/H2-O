package com.h2o.h2oServer.domain.options.application;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.options.dto.*;
import com.h2o.h2oServer.domain.options.entity.TrimDefaultOptionEntity;
import com.h2o.h2oServer.domain.options.entity.TrimExtraOptionEntity;
import com.h2o.h2oServer.domain.options.enums.OptionType;
import com.h2o.h2oServer.domain.options.mapper.OptionsMapper;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchTrimException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class OptionsService {

    private final OptionsMapper optionsMapper;

    public List<TrimExtraOptionDto> findTrimPackages(Long trimId) {
        List<TrimExtraOptionEntity> extraOptionEntities = optionsMapper.findTrimPackages(trimId);
        validateExistenceOfOptions(extraOptionEntities);
        return addPackages(extraOptionEntities);
    }

    public List<TrimExtraOptionDto> findTrimPackages(Long trimId, PageRangeDto pageRangeDto) {
        List<TrimExtraOptionEntity> extraOptionEntities = optionsMapper.findTrimPackagesWithRange(trimId, pageRangeDto);
        validateExistenceOfOptions(extraOptionEntities);
        return addPackages(extraOptionEntities);
    }

    public List<TrimExtraOptionDto> findTrimExtraOptions(Long trimId) {
        List<TrimExtraOptionEntity> extraOptionEntities = optionsMapper.findTrimExtraOptions(trimId);
        validateExistenceOfOptions(extraOptionEntities);
        return addExtraOptions(extraOptionEntities);
    }

    public List<TrimExtraOptionDto> findTrimExtraOptions(Long trimId, PageRangeDto pageRangeDto) {
        List<TrimExtraOptionEntity> extraOptionEntities = optionsMapper.findTrimExtraOptionsWithRange(trimId, pageRangeDto);
        validateExistenceOfOptions(extraOptionEntities);
        return addExtraOptions(extraOptionEntities);
    }

    public List<TrimDefaultOptionDto> findTrimDefaultOptions(Long trimId) {
        List<TrimDefaultOptionEntity> defaultOptionEntities = optionsMapper.findTrimDefaultOptions(trimId);
        validateExistenceOfOptions(defaultOptionEntities);
        return addDefaultOptions(defaultOptionEntities);
    }

    public List<TrimDefaultOptionDto> findTrimDefaultOptions(Long trimId, PageRangeDto pageRangeDto) {
        List<TrimDefaultOptionEntity> defaultOptionEntities = optionsMapper.findTrimDefaultOptionsWithRange(trimId, pageRangeDto);
        validateExistenceOfOptions(defaultOptionEntities);
        return addDefaultOptions(defaultOptionEntities);
    }

    public ExtraOptionSizeDto findTrimExtraOptionSize(Long trimId) {
        return ExtraOptionSizeDto.of(
                optionsMapper.findTrimPackageSize(trimId), optionsMapper.findTrimOptionSize(trimId, OptionType.EXTRA)
        );
    }

    public DefaultOptionSizeDto findTrimDefaultOptionSize(Long trimId) {
        return DefaultOptionSizeDto.of(optionsMapper.findTrimOptionSize(trimId, OptionType.DEFAULT));
    }

    private List<TrimExtraOptionDto> addPackages(List<TrimExtraOptionEntity> extraOptionEntities) {
        List<TrimExtraOptionDto> trimExtraOptionDtos = new ArrayList<>();

        for (TrimExtraOptionEntity extraOptionEntity : extraOptionEntities) {
            Long packageId = extraOptionEntity.getId();
            List<HashTagEntity> packageHashTags = optionsMapper.findPackageHashTags(packageId);

            TrimExtraOptionDto trimExtraOptionDto = TrimExtraOptionDto.of(true, extraOptionEntity, packageHashTags);

            Collections.sort(trimExtraOptionDto.getHashTags());

            trimExtraOptionDtos.add(trimExtraOptionDto);
        }

        return trimExtraOptionDtos;
    }

    private List<TrimExtraOptionDto> addExtraOptions(List<TrimExtraOptionEntity> extraOptionEntities) {
        List<TrimExtraOptionDto> trimExtraOptionDtos = new ArrayList<>();

        for (TrimExtraOptionEntity extraOptionEntity : extraOptionEntities) {
            Long optionId = extraOptionEntity.getId();
            List<HashTagEntity> optionHashTags = optionsMapper.findOptionHashTag(optionId);

            TrimExtraOptionDto trimExtraOptionDto = TrimExtraOptionDto.of(false, extraOptionEntity, optionHashTags);

            Collections.sort(trimExtraOptionDto.getHashTags());

            trimExtraOptionDtos.add(trimExtraOptionDto);
        }

        return trimExtraOptionDtos;
    }

    private List<TrimDefaultOptionDto> addDefaultOptions(List<TrimDefaultOptionEntity> defaultOptionEntities) {
        List<TrimDefaultOptionDto> trimDefaultOptionDtos = new ArrayList<>();

        for (TrimDefaultOptionEntity defaultOptionEntity : defaultOptionEntities) {
            Long optionId = defaultOptionEntity.getId();
            List<HashTagEntity> optionHashTags = optionsMapper.findOptionHashTag(optionId);

            TrimDefaultOptionDto trimDefaultOptionDto = TrimDefaultOptionDto.of(defaultOptionEntity, optionHashTags);

            Collections.sort(trimDefaultOptionDto.getHashTags());

            trimDefaultOptionDtos.add(trimDefaultOptionDto);
        }

        return trimDefaultOptionDtos;
    }

    private static void validateExistenceOfOptions(List entities) {
        if (entities == null || entities.isEmpty()) {
            throw new NoSuchTrimException();
        }
    }
}
