package com.h2o.h2oServer.domain.optionPackage.application;

import com.h2o.h2oServer.domain.option.application.OptionService;
import com.h2o.h2oServer.domain.option.dto.OptionDto;
import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.enums.HashTag;
import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import com.h2o.h2oServer.domain.optionPackage.dto.PackageDetailsDto;
import com.h2o.h2oServer.domain.optionPackage.entity.PackageEntity;
import com.h2o.h2oServer.domain.optionPackage.mapper.PackageMapper;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;

import java.util.List;

import static org.mockito.Mockito.when;

@MybatisTest
class PackageServiceTest {
    private static PackageService packageService;
    private static OptionService optionService;
    private static PackageMapper packageMapper;
    private static SoftAssertions softly;

    @BeforeAll
    static void beforeAll() {
        packageMapper = Mockito.mock(PackageMapper.class);
        optionService = Mockito.mock(OptionService.class);
        packageService = new PackageService(packageMapper, optionService);
        softly = new SoftAssertions();
    }

    @Test
    @DisplayName("존재하는 package, trim에 대한 요청인 경우 Dto로 formatting해서 반환한다.")
    void findPackageInformation() {
        //given
        Long trimId = 1L;
        Long packageId = 1L;
        when(packageMapper.findPackage(trimId, packageId)).thenReturn(generatePackageEntity());
        when(packageMapper.findHashTag(packageId)).thenReturn(generateHashTagEntities());
        when(packageMapper.findOptionComponent(packageId)).thenReturn(List.of(1L, 2L));
        when(optionService.findOptionInformation(1L)).thenReturn(OptionDto.builder()
                .name("first")
                .containsHmgData(true)
                .build());
        when(optionService.findOptionInformation(2L)).thenReturn(OptionDto.builder()
                .name("second")
                .containsHmgData(false)
                .build());

        //when
        PackageDetailsDto actualPackageDetailsDto = packageService.findPackageInformation(trimId, packageId);
        //then
        softly.assertThat(actualPackageDetailsDto).as("null이 아니다.").isNotNull();
        softly.assertThat(actualPackageDetailsDto.getHashTags()).as("세 개의 hashtag 정보를 포함한다.").hasSize(3);
        softly.assertThat(actualPackageDetailsDto.getName()).as("name = package name이다.").isEqualTo("package name");
        softly.assertThat(actualPackageDetailsDto.getCategory()).as("category = 편의").isEqualTo(OptionCategory.CONVENIENCE.getLabel());
        softly.assertThat(actualPackageDetailsDto.getComponents()).as("유효한 hmgData를 포함한다.").contains(OptionDto.builder()
                .name("second")
                .containsHmgData(false)
                .build())
                .contains(OptionDto.builder()
                .name("first")
                .containsHmgData(true)
                .build());
        softly.assertAll();
    }

    private static PackageEntity generatePackageEntity() {
        return PackageEntity.builder()
                .name("package name")
                .price(123)
                .choiceRatio(0.3f)
                .category(OptionCategory.CONVENIENCE)
                .build();
    }

    private static List<HashTagEntity> generateHashTagEntities() {
        return List.of(
                HashTagEntity.builder()
                        .name(HashTag.CAMPING)
                        .build(),
                HashTagEntity.builder()
                        .name(HashTag.LEISURE)
                        .build(),
                HashTagEntity.builder()
                        .name(HashTag.SPORTS)
                        .build()
        );
    }
}
