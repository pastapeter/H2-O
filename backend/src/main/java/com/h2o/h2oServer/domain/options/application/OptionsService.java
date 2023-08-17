package com.h2o.h2oServer.domain.options.application;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.options.dto.TrimDefaultOptionDto;
import com.h2o.h2oServer.domain.options.dto.TrimExtraOptionDto;
import com.h2o.h2oServer.domain.options.entity.TrimDefaultOptionEntity;
import com.h2o.h2oServer.domain.options.entity.TrimExtraOptionEntity;
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
        List<TrimExtraOptionDto> trimExtraOptionDtos = new ArrayList<>();

        List<TrimExtraOptionEntity> extraOptionEntities = optionsMapper.findTrimPackages(trimId);

        validateExistenceOfOptions(extraOptionEntities);

        for (TrimExtraOptionEntity extraOptionEntity : extraOptionEntities) {
            Long packageId = extraOptionEntity.getId();
            List<HashTagEntity> packageHashTags = optionsMapper.findPackageHashTags(packageId);

            TrimExtraOptionDto trimExtraOptionDto = TrimExtraOptionDto.of(true, extraOptionEntity, packageHashTags);

            Collections.sort(trimExtraOptionDto.getHashTags());

            trimExtraOptionDtos.add(trimExtraOptionDto);
        }

        return trimExtraOptionDtos;
    }

    public List<TrimExtraOptionDto> findTrimExtraOptions(Long trimId) {
        List<TrimExtraOptionDto> trimExtraOptionDtos = new ArrayList<>();

        List<TrimExtraOptionEntity> extraOptionEntities = optionsMapper.findTrimExtraOptions(trimId);

        validateExistenceOfOptions(extraOptionEntities);

        for (TrimExtraOptionEntity extraOptionEntity : extraOptionEntities) {
            Long optionId = extraOptionEntity.getId();
            List<HashTagEntity> optionHashTags = optionsMapper.findOptionHashTag(optionId);

            TrimExtraOptionDto trimExtraOptionDto = TrimExtraOptionDto.of(false, extraOptionEntity, optionHashTags);

            Collections.sort(trimExtraOptionDto.getHashTags());

            trimExtraOptionDtos.add(trimExtraOptionDto);
        }

        return trimExtraOptionDtos;
    }

    public List<TrimDefaultOptionDto> findTrimDefaultOptions(Long trimId) {
        List<TrimDefaultOptionDto> trimDefaultOptionDtos = new ArrayList<>();

        List<TrimDefaultOptionEntity> defaultOptionEntities = optionsMapper.findTrimDefaultOptions(trimId);

        validateExistenceOfOptions(defaultOptionEntities);

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
