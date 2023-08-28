package com.h2o.h2oServer.domain.optionPackage.application;

import com.h2o.h2oServer.domain.option.application.OptionService;
import com.h2o.h2oServer.domain.option.dto.OptionDto;
import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import com.h2o.h2oServer.domain.optionPackage.PackageFixture;
import com.h2o.h2oServer.domain.optionPackage.dto.PackageDetailsDto;
import com.h2o.h2oServer.domain.optionPackage.mapper.PackageMapper;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;

import java.util.List;
import java.util.Optional;

import static com.h2o.h2oServer.domain.option.HashTagFixture.generateHashTagEntities;
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
        List<OptionDto> expectedOptionDtos = generateOptionDtos();
        when(packageMapper.findPackage(trimId, packageId)).thenReturn(Optional.ofNullable(PackageFixture.generatePackageEntity()));
        when(packageMapper.findHashTag(packageId)).thenReturn(generateHashTagEntities());
        when(packageMapper.findOptionComponent(packageId)).thenReturn(List.of(1L, 2L));
        when(optionService.findOptionInformation(1L)).thenReturn(expectedOptionDtos.get(0));
        when(optionService.findOptionInformation(2L)).thenReturn(expectedOptionDtos.get(1));

        //when
        PackageDetailsDto actualPackageDetailsDto = packageService.findPackageInformation(trimId, packageId);
        //then
        softly.assertThat(actualPackageDetailsDto)
                .as("null이 아니다.")
                .isNotNull();
        softly.assertThat(actualPackageDetailsDto.getHashTags())
                .as("세 개의 hashtag 정보를 포함한다.")
                .hasSize(3);
        softly.assertThat(actualPackageDetailsDto.getName())
                .as("name = Package 1이다.")
                .isEqualTo("Package 1");
        softly.assertThat(actualPackageDetailsDto.getCategory())
                .as("category = 세부상품")
                .isEqualTo(OptionCategory.DETAILED_ITEM.getLabel());
        softly.assertThat(actualPackageDetailsDto.getComponents())
                .as("유효한 hmgData를 포함한다.")
                .containsAll(expectedOptionDtos);
        softly.assertAll();
    }

    private static List<OptionDto> generateOptionDtos() {
        return List.of(
                OptionDto.builder()
                        .name("first")
                        .containsHmgData(true)
                        .build(),
                OptionDto.builder()
                        .name("second")
                        .containsHmgData(false)
                        .build());
    }

}
