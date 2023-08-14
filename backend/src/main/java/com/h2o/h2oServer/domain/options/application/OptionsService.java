package com.h2o.h2oServer.domain.options.application;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.options.dto.TrimOptionDto;
import com.h2o.h2oServer.domain.options.entity.TrimOptionEntity;
import com.h2o.h2oServer.domain.options.entity.enums.OptionType;
import com.h2o.h2oServer.domain.options.mapper.OptionsMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class OptionsService {

    private final OptionsMapper optionsMapper;

    public List<TrimOptionDto> findTrimPackages(Long trimId) {
        List<TrimOptionDto> trimOptionDtos = new ArrayList<>();

        List<TrimOptionEntity> trimPackageEntities = optionsMapper.findTrimPackages(trimId);

        for (TrimOptionEntity trimOptionEntity : trimPackageEntities) {
            Long packageId = trimOptionEntity.getId();
            List<HashTagEntity> packageHashTags = optionsMapper.findPackageHashTags(packageId);

            TrimOptionDto trimOptionDto = TrimOptionDto.of(true, trimOptionEntity, packageHashTags);

            Collections.sort(trimOptionDto.getHashTags());

            trimOptionDtos.add(trimOptionDto);
        }

        return trimOptionDtos;
    }

    public List<TrimOptionDto> findTrimOptions(Long trimId, OptionType optionType) {
        List<TrimOptionDto> trimOptionDtos = new ArrayList<>();

        List<TrimOptionEntity> extraOptionsEntities = optionsMapper.findTrimOptions(trimId, optionType);

        for (TrimOptionEntity extraOptionsEntity : extraOptionsEntities) {
            Long optionId = extraOptionsEntity.getId();
            List<HashTagEntity> optionHashTags = optionsMapper.findOptionHashTag(optionId);

            TrimOptionDto trimOptionDto = TrimOptionDto.of(false, extraOptionsEntity, optionHashTags);

            Collections.sort(trimOptionDto.getHashTags());

            trimOptionDtos.add(trimOptionDto);
        }

        return trimOptionDtos;
    }

}
