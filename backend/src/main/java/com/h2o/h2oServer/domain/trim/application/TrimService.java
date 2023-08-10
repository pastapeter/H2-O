package com.h2o.h2oServer.domain.trim.application;

import com.h2o.h2oServer.domain.trim.dto.TrimDto;
import com.h2o.h2oServer.domain.trim.entity.ImageEntity;
import com.h2o.h2oServer.domain.trim.entity.OptionStatisticsEntity;
import com.h2o.h2oServer.domain.trim.entity.TrimEntity;
import com.h2o.h2oServer.domain.trim.mapper.TrimMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TrimService {
    private final TrimMapper trimMapper;

    public List<TrimDto> findTrimInformation(Long vehicleId) {
        List<TrimEntity> trimEntities = trimMapper.findByCarId(vehicleId);

        List<TrimDto> trimDtos = trimEntities.stream()
                .map(trimEntity -> {
                    Long trimId = trimEntity.getId();
                    List<OptionStatisticsEntity> optionStatisticsEntities = trimMapper.findOptionStatistics(trimId);
                    List<ImageEntity> imageEntities = trimMapper.findImages(trimId);

                    return TrimDto.of(trimEntity, imageEntities, optionStatisticsEntities);
                })
                .collect(Collectors.toList());

        return trimDtos;
    }
}
