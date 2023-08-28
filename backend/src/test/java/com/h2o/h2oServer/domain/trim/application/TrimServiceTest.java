package com.h2o.h2oServer.domain.trim.application;

import com.h2o.h2oServer.domain.car.mapper.CarMapper;
import com.h2o.h2oServer.domain.model_type.application.ModelTypeService;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchExternalColorException;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchInternalColorException;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchTrimException;
import com.h2o.h2oServer.domain.trim.dto.ExternalColorDto;
import com.h2o.h2oServer.domain.trim.dto.InternalColorDto;
import com.h2o.h2oServer.domain.trim.dto.PriceRangeDto;
import com.h2o.h2oServer.domain.trim.dto.TrimDto;
import com.h2o.h2oServer.domain.trim.dto.*;
import com.h2o.h2oServer.domain.trim.mapper.ExternalColorMapper;
import com.h2o.h2oServer.domain.trim.mapper.TrimMapper;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.*;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.mockito.Mockito;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.Optional;

import static com.h2o.h2oServer.domain.option.OptionFixture.generateOptionStatisticsList;
import static com.h2o.h2oServer.domain.trim.ExternalColorFixture.generateExternalColorEntityList;
import static com.h2o.h2oServer.domain.trim.ImageFixture.generateImageEntityList;
import static com.h2o.h2oServer.domain.trim.InternalColorFixture.generateInernalColorEntityList;
import static com.h2o.h2oServer.domain.trim.TrimFixture.generateTrimEntity;
import static com.h2o.h2oServer.domain.trim.TrimFixture.generateTrimEntityList;
import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.when;

@SpringBootTest
class TrimServiceTest {

    private static TrimMapper trimMapper;
    private static CarMapper carMapper;
    private static ExternalColorMapper externalColorMapper;
    private static ModelTypeService modelTypeService;
    private static TrimService trimService;
    private static SoftAssertions softly;

    @BeforeAll
    static void beforeAll() {
        trimMapper = Mockito.mock(TrimMapper.class);
        externalColorMapper = Mockito.mock(ExternalColorMapper.class);
        carMapper = Mockito.mock(CarMapper.class);
        modelTypeService = Mockito.mock(ModelTypeService.class);
        trimService = new TrimService(trimMapper, externalColorMapper, carMapper, modelTypeService);
        softly = new SoftAssertions();
    }

    @Nested
    @DisplayName("트림 정보 조회 테스트")
    class findTrimInformationTest {
        @Test
        @DisplayName("존재하는 car에 대한 요청인 경우 Dto로 formatting해서 반환한다.")
        void findTrimInformation() {
            //given
            Long carId = 1L;
            when(trimMapper.findByCarId(carId)).thenReturn(generateTrimEntityList());
            when(trimMapper.findOptionStatistics(1L)).thenReturn(generateOptionStatisticsList());
            when(trimMapper.findOptionStatistics(2L)).thenReturn(generateOptionStatisticsList());
            when(trimMapper.findImages(1L)).thenReturn(generateImageEntityList());
            when(trimMapper.findImages(2L)).thenReturn(generateImageEntityList());

            //when
            List<TrimDto> actualTrimDtos = trimService.findTrimInformation(carId);

            //then
            softly.assertThat(actualTrimDtos).as("null이 아니다.").isNotNull();
            softly.assertThat(actualTrimDtos).as("TrimDto를 포함한다.").isNotEmpty();
            softly.assertThat(actualTrimDtos.get(0).getImages()).as("Images를 포함한다.").isNotNull();
            softly.assertThat(actualTrimDtos.get(0).getOptions()).as("Options를 포함한다.").isNotNull();
            softly.assertAll();
        }

        @Test
        @DisplayName("존재하지 않는 차량에 대한 요청인 경우 NoSuchTrimException을 발생시킨다.")
        void findTrimInformationNotExist() {
            //given
            Long carId = Long.MAX_VALUE;
            when(trimMapper.findByCarId(carId)).thenReturn(List.of());

            //when
            //then
            assertThatThrownBy(() -> trimService.findTrimInformation(carId))
                    .isInstanceOf(NoSuchTrimException.class);
        }
    }

    @Nested
    @DisplayName("색상 정보 조회 테스트")
    class findColorInformationTest {
        @Test
        @DisplayName("존재하는 externalColor에 대한 요청인 경우, Dto로 포매팅해서 반환한다.")
        void findExternalColorInformation() {
            //given
            Long trimId = 1L;
            when(trimMapper.findExternalColor(trimId)).thenReturn(generateExternalColorEntityList());
            when(externalColorMapper.findImages(1L)).thenReturn(generateImageEntityList());
            when(externalColorMapper.findImages(2L)).thenReturn(generateImageEntityList());

            //when
            List<ExternalColorDto> actualExternalColorDtos = trimService.findExternalColorInformation(trimId);

            //then
            softly.assertThat(actualExternalColorDtos).as("ExternalColorDtos를 두 개 포함한다.").hasSize(2);
            softly.assertThat(actualExternalColorDtos.get(0).getImages()).as("Images를 포함한다.").isNotNull();
            softly.assertThat(actualExternalColorDtos.get(0).getName()).as("name 필드를 포함한다.").isNotNull();
            softly.assertAll();
        }

        @Test
        @DisplayName("존재하지 않는 externalColor에 대한 요청인 경우, NoSuchExternalColorException을 발생시킨다.")
        void findExternalColorInformationNotExist() {
            //given
            Long trimId = 1L;
            when(trimMapper.findExternalColor(trimId)).thenReturn(List.of());

            //when
            //then
            assertThatThrownBy(() -> trimService.findExternalColorInformation(trimId))
                    .isInstanceOf(NoSuchExternalColorException.class);
        }

        @Test
        @DisplayName("trimId에 해당하는 internalColor를 Dto로 포매팅해서 반환한다.")
        void findInternalColorInformation() {
            //given
            Long trimId = 1L;
            when(trimMapper.findInternalColor(trimId)).thenReturn(generateInernalColorEntityList());

            //when
            List<InternalColorDto> actualInternalColorDtos = trimService.findInternalColorInformation(trimId);

            //then
            softly.assertThat(actualInternalColorDtos).as("입력받은 entity의 개수만큼 dto를 담고 있다.")
                    .hasSize(2);
            softly.assertThat(actualInternalColorDtos.get(0).getName()).as("입력받은 entity의 정보를 가지고 있다.")
                    .isEqualTo("Red");
            softly.assertThat(actualInternalColorDtos.get(1).getName()).as("입력받은 entity의 정보를 가지고 있다.")
                    .isEqualTo("Blue");
        }

        @Test
        @DisplayName("존재하지 않는 internalColor에 대한 요청인 경우, NoSuchInternalException을 발생시킨다.")
        void findInternalColorInformationNotExist() {
            //given
            Long trimId = 1L;
            when(trimMapper.findInternalColor(trimId)).thenReturn(List.of());

            //when
            //then
            assertThatThrownBy(() -> trimService.findInternalColorInformation(trimId))
                    .isInstanceOf(NoSuchInternalColorException.class);
        }
    }

    @Nested
    @DisplayName("트림 가격 분포 테스트")
    class PriceDistributionTest {
        @ParameterizedTest
        @DisplayName("트림의 가격 범위를 반환한다.")
        @CsvSource({
                "20000, 10000, 0",
                "15000, 5000, 0",
                "25000, 15000, 5000"
        })
        void findPriceRange(int maxComponentPrice, int maxModeltypePrice, int minModeltypePrice) {
            //given
            Long trimId = 1L;
            long carId = 1L;
            int trimPrice = 50000;

            when(trimMapper.findById(trimId)).thenReturn(Optional.ofNullable(generateTrimEntity(carId)));
            when(trimMapper.findMaximumComponentPrice(trimId)).thenReturn(maxComponentPrice);
            when(carMapper.findMaximumModelTypePrice(carId)).thenReturn(maxModeltypePrice);
            when(carMapper.findMinimumModelTypePrice(carId)).thenReturn(minModeltypePrice);

            PriceRangeDto expectedPriceRange = PriceRangeDto.of(maxComponentPrice + trimPrice + maxModeltypePrice,
                    trimPrice + minModeltypePrice);

            //when
            PriceRangeDto actualPriceRange = trimService.findPriceRange(trimId);

            //then
            assertThat(actualPriceRange).isEqualTo(expectedPriceRange);
        }

        @Test
        @DisplayName("존재하는 가격 범위 내의 분포 정보를 dto로 반환한다.")
        void findAndScalePriceDistribution() {
            //given
            Long trimId = 1L;
            Long carId = 1L;
            when(trimMapper.findById(trimId)).thenReturn(Optional.ofNullable(generateTrimEntity(carId)));
            when(trimMapper.findMaximumComponentPrice(trimId)).thenReturn(5000000);
            when(carMapper.findMaximumModelTypePrice(carId)).thenReturn(5000000);
            when(carMapper.findMinimumModelTypePrice(carId)).thenReturn(0);
            int unit = 10000000 / 30;

            for (int index = 0; index < 30; index++) {
                when(trimMapper.findQuantityBetween(trimId, 50000 + unit * index, 50000 + unit * (index + 1))).thenReturn(5);
            }

            //when
            PriceDistributionDto actualDto = trimService.findAndScalePriceDistribution(trimId);

            //then
            softly.assertThat(actualDto.getUnit()).isEqualTo(unit);
            softly.assertThat(actualDto.getQuantityPerUnit()).hasSize(30);
            softly.assertThat(actualDto.getQuantityPerUnit()).allMatch(quantity -> quantity == 5);
            softly.assertAll();
        }
    }
}
