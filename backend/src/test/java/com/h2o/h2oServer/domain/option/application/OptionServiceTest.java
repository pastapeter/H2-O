package com.h2o.h2oServer.domain.option.application;

import com.h2o.h2oServer.domain.option.OptionFixture;
import com.h2o.h2oServer.domain.option.dto.*;
import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import com.h2o.h2oServer.domain.option.exception.NoSuchOptionException;
import com.h2o.h2oServer.domain.option.mapper.OptionMapper;
import com.h2o.h2oServer.domain.optionPackage.mapper.PackageMapper;
import org.assertj.core.api.SoftAssertions;
import org.assertj.core.util.Lists;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.List;
import java.util.Optional;

import static com.h2o.h2oServer.domain.option.HashTagFixture.generateHashTagEntities;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.when;

class OptionServiceTest {
    private static OptionMapper optionMapper;
    private static OptionService optionService;
    private static PackageMapper packageMapper;
    private static SoftAssertions softly;

    @BeforeAll
    static void beforeAll() {
        optionMapper = Mockito.mock(OptionMapper.class);
        packageMapper = Mockito.mock(PackageMapper.class);
        optionService = new OptionService(optionMapper, packageMapper);
        softly = new SoftAssertions();
    }

    @Nested
    @DisplayName("옵션 세부 정보 테스트")
    class findDetailedOptionInformationTest {
        @Test
        @DisplayName("존재하는 option, trim에 대한 요청인 경우 Dto로 formatting해서 반환한다.")
        void findDetailedOptionInformation() {
            //given
            long optionId = 1L;
            long trimId = 1L;
            when(optionMapper.findOptionDetails(optionId, trimId))
                    .thenReturn(Optional.ofNullable(OptionFixture.generateOptionDetailsEntity()));
            when(optionMapper.findHashTag(optionId))
                    .thenReturn(generateHashTagEntities());

            //when
            OptionDetailsDto actualOptionDetailsDto = optionService.findDetailedOptionInformation(optionId, trimId);

            //then
            softly.assertThat(actualOptionDetailsDto).as("null이 아니다.")
                    .isNotNull();
            softly.assertThat(actualOptionDetailsDto.getHashTags()).as("세 개의 hashtag 정보를 포함한다.")
                    .hasSize(3);
            softly.assertThat(actualOptionDetailsDto.getName()).as("name = Option 1이다.")
                    .isEqualTo("Option 1");
            softly.assertThat(actualOptionDetailsDto.getCategory()).as("category = 성능/파워트레인")
                    .isEqualTo(OptionCategory.POWERTRAIN_PERFORMANCE.getLabel());
            softly.assertThat(actualOptionDetailsDto.getHmgData()).as("유효한 hmgData를 포함한다.")
                    .isEqualTo(OptionStatisticsDto.of(0.3f, 13));
            softly.assertAll();
        }

        @Test
        @DisplayName("존재하지 않는 option에 대한 요청인 경우 NoSuchOptionException을 발생시킨다.")
        void findDetailedOptionInformationNotExists() {
            //given
            long optionId = 1L;
            long trimId = 1L;
            when(optionMapper.findOptionDetails(optionId, trimId)).thenReturn(Optional.empty());

            //when
            //then
            assertThatThrownBy(() -> optionService.findDetailedOptionInformation(optionId, trimId))
                    .isInstanceOf(NoSuchOptionException.class);
        }
    }

    @Nested
    @DisplayName("옵션 정보 반환 테스트")
    class findOptionInformationTest {
        @Test
        @DisplayName("존재하는 option에 대한 요청인 경우 Dto로 formatting해서 반환한다.")
        void findOptionInformation() {
            //given
            long optionId = 1L;
            when(optionMapper.findOption(optionId)).thenReturn(Optional.ofNullable(OptionFixture.generateOptionEntity()));
            when(optionMapper.findHashTag(optionId)).thenReturn(generateHashTagEntities());

            //when
            OptionDto actualOptionDto = optionService.findOptionInformation(optionId);

            //then
            softly.assertThat(actualOptionDto).as("null이 아니다.")
                    .isNotNull();
            softly.assertThat(actualOptionDto.getHashTags()).as("세 개의 hashtag 정보를 포함한다.")
                    .hasSize(3);
            softly.assertThat(actualOptionDto.getName()).as("name = Option 1이다.")
                    .isEqualTo("Option 1");
            softly.assertThat(actualOptionDto.getCategory()).as("category = 성능/파워트레인")
                    .isEqualTo(OptionCategory.POWERTRAIN_PERFORMANCE.getLabel());
            softly.assertAll();
        }

        @Test
        @DisplayName("존재하지 않는 option에 대한 요청인 경우 NoSuchOptionException을 발생시킨다.")
        void findOptionInformationNotExists() {
            //given
            long optionId = 1L;
            when(optionMapper.findOption(optionId)).thenReturn(Optional.empty());

            //when
            //then
            assertThatThrownBy(() -> optionService.findOptionInformation(optionId))
                    .isInstanceOf(NoSuchOptionException.class);
        }
    }

    @Nested
    @DisplayName("패키지 옵션 반환 테스트")
    class findTrimPackagesTest {
        @Test
        @DisplayName("존재하는 trim에 대한 요청인 경우 Dto로 formatting해서 List로 반환한다.")
        void findTrimPackages() {
            //given
            long trimId = 1L;
            when(optionMapper.findTrimPackages(trimId)).thenReturn(OptionFixture.generateExtraOptionEntityList());

            //when
            List<TrimExtraOptionDto> trimPackageDtos = optionService.findTrimPackages(trimId);

            //then
            softly.assertThat(trimPackageDtos).as("null이 아니다.")
                    .isNotNull();
            softly.assertThat(trimPackageDtos).as("두 개의 패키지를 반환한다.")
                    .hasSize(2);
            softly.assertThat(trimPackageDtos.get(0).getName()).as("첫 번째 패키지의 이름은 Option 1이다.")
                    .isEqualTo("Option 1");
            softly.assertAll();
        }

        @Test
        @DisplayName("반환하고자하는 entity가 없을 때 NoSuchOptionException를 발생시킨다.")
        void findTrimPackagesNotExist() {
            //given
            long trimId = 1L;
            when(optionMapper.findTrimPackages(trimId)).thenReturn(Lists.emptyList());

            //when
            //then
            assertThatThrownBy(() -> optionService.findTrimPackages(trimId))
                    .isInstanceOf(NoSuchOptionException.class);
        }
    }

    @Nested
    @DisplayName("추가 옵션 반환 테스트")
    class findTrimExtraOptionsTest {
        @Test
        @DisplayName("존재하는 trim에 대한 요청인 경우 Dto로 formatting해서 List로 반환한다.")
        void findTrimExtraOptions() {
            //given
            long trimId = 1L;
            when(optionMapper.findTrimExtraOptions(trimId)).thenReturn(OptionFixture.generateExtraOptionEntityList());

            //when
            List<TrimExtraOptionDto> trimExtraOptionDtos = optionService.findTrimExtraOptions(trimId);

            //then
            softly.assertThat(trimExtraOptionDtos).as("null이 아니다.")
                    .isNotNull();
            softly.assertThat(trimExtraOptionDtos).as("두 개의 추가 옵션을 반환한다.")
                    .hasSize(2);
            softly.assertThat(trimExtraOptionDtos.get(0).getName()).as("첫 번째 패키지의 이름은 Option 1이다.")
                    .isEqualTo("Option 1");
            softly.assertAll();
        }

        @Test
        @DisplayName("반환하고자 하는 entity가 없을 때 NoSuchOptionException를 발생시킨다.")
        void findTrimOptionsNotExist() {
            //given
            long trimId = 1L;
            when(optionMapper.findTrimExtraOptions(trimId)).thenReturn(Lists.emptyList());

            //when
            //then
            assertThatThrownBy(() -> optionService.findTrimExtraOptions(trimId))
                    .isInstanceOf(NoSuchOptionException.class);
        }
    }

    @Nested
    @DisplayName("기본 옵션 반환 테스트")
    class findTrimDefaultOptionsTest {
        @Test
        @DisplayName("존재하는 trim에 대한 요청인 경우 Dto로 formating하여 List로 반환한다.")
        void findTrimDefaultOptions() {
            //given
            long trimId = 1L;
            when(optionMapper.findTrimDefaultOptions(trimId)).thenReturn(OptionFixture.generateDefaultOptionEntityList());

            //when
            List<TrimDefaultOptionDto> trimDefaultOptions = optionService.findTrimDefaultOptions(trimId);

            //then
            softly.assertThat(trimDefaultOptions).as("null이 아니다.")
                    .isNotNull();
            softly.assertThat(trimDefaultOptions).as("두 개의 기본 옵션을 반환한다.")
                    .hasSize(2);
            softly.assertThat(trimDefaultOptions.get(0).getName()).as("첫 번째 옵션의 이름은 Option 1이다.")
                    .isEqualTo("Option 1");
            softly.assertAll();
        }

        @Test
        @DisplayName("반환하고자 하는 entity가 없을 때 NoSuchOptionException를 발생시킨다.")
        void findTrimOptionsNotExist() {
            //given
            long trimId = 1L;
            when(optionMapper.findTrimDefaultOptions(trimId)).thenReturn(Lists.emptyList());

            //when
            //then
            assertThatThrownBy(() -> optionService.findTrimDefaultOptions(trimId))
                    .isInstanceOf(NoSuchOptionException.class);
        }
    }
}
