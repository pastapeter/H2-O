package com.h2o.h2oServer.domain.trim.application;

import com.h2o.h2oServer.domain.car.mapper.CarMapper;
import com.h2o.h2oServer.domain.model_type.application.ModelTypeService;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchTrimException;
import com.h2o.h2oServer.domain.trim.dto.ExternalColorDto;
import com.h2o.h2oServer.domain.trim.dto.InternalColorDto;
import com.h2o.h2oServer.domain.trim.dto.PriceRangeDto;
import com.h2o.h2oServer.domain.trim.dto.TrimDto;
import com.h2o.h2oServer.domain.trim.entity.ExternalColorEntity;
import com.h2o.h2oServer.domain.trim.entity.ImageEntity;
import com.h2o.h2oServer.domain.trim.entity.OptionStatisticsEntity;
import com.h2o.h2oServer.domain.trim.entity.TrimEntity;
import com.h2o.h2oServer.domain.trim.mapper.ExternalColorMapper;
import com.h2o.h2oServer.domain.trim.mapper.TrimMapper;
import com.h2o.h2oServer.domain.trim.entity.InternalColorEntity;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.*;
import org.mockito.Mockito;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

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

    @BeforeEach
    void setUp() {
    }

    @Test
    @DisplayName("존재하는 vehicle에 대한 요청인 경우 Dto로 formatting해서 반환한다.")
    void findTrimInformation() {
        //given
        Long vehicleId = 1L;
        when(trimMapper.findByCarId(vehicleId)).thenReturn(generateTrimEntityList());
        when(trimMapper.findOptionStatistics(1L)).thenReturn(generateOptionStatisticsList());
        when(trimMapper.findOptionStatistics(2L)).thenReturn(generateOptionStatisticsList());
        when(trimMapper.findImages(1L)).thenReturn(generateImageEntityList());
        when(trimMapper.findImages(2L)).thenReturn(generateImageEntityList());

        //when
        List<TrimDto> actualTrimDtos = trimService.findTrimInformation(vehicleId);

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
        softly.assertThat(actualExternalColorDtos).as("null이 아니다.").isNotNull();
        softly.assertThat(actualExternalColorDtos).as("ExternalColorDtos를 두 개 포함한다.").hasSize(2);
        softly.assertThat(actualExternalColorDtos.get(0).getImages()).as("Images를 포함한다.").isNotNull();
        softly.assertThat(actualExternalColorDtos.get(0).getName()).as("name 필드를 포함한다.").isNotNull();
        softly.assertAll();
    }

    @Test
    @DisplayName("존재하지 않는 externalColor에 대한 요청인 경우, NoSuchTrimException을 발생시킨다.")
    void findExternalColorInformationNotExist() {
        //given
        Long trimId = 1L;
        when(trimMapper.findExternalColor(trimId)).thenReturn(List.of());

        //when
        //then
        assertThatThrownBy(() -> trimService.findExternalColorInformation(trimId))
                .isInstanceOf(NoSuchTrimException.class);
    }

    private static List<ExternalColorEntity> generateExternalColorEntityList() {
        return List.of(
                ExternalColorEntity.builder()
                        .id(1L)
                        .name("Red")
                        .colorCode("#FF0000")
                        .choiceRatio(0.5F)
                        .price(100)
                        .build(),
                ExternalColorEntity.builder()
                        .id(2L)
                        .name("Black")
                        .colorCode("#FF0001")
                        .choiceRatio(0.2F)
                        .price(240)
                        .build());
    }

    private static List<ImageEntity> generateImageEntityList() {
        return List.of(
                ImageEntity.builder()
                        .image("url1")
                        .id(1L)
                        .build(),
                ImageEntity.builder()
                        .image("url2")
                        .id(2L)
                        .build()
        );
    }

    private List<OptionStatisticsEntity> generateOptionStatisticsList() {
        return List.of(
                OptionStatisticsEntity.builder()
                        .id(1L)
                        .name("Option A")
                        .useCount(0.75F)
                        .build(),
                OptionStatisticsEntity.builder()
                        .id(2L)
                        .name("Option B")
                        .useCount(0.5F)
                        .build()
        );
    }

    private List<TrimEntity> generateTrimEntityList() {
        return List.of(
                TrimEntity.builder()
                        .id(1L)
                        .name("Trim A")
                        .description("Description of Trim A")
                        .price(50000)
                        .build(),
                TrimEntity.builder()
                        .id(2L)
                        .name("Trim B")
                        .description("Description of Trim b")
                        .price(70000)
                        .build()
        );
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
        softly.assertThat(actualInternalColorDtos).as("null이 아니다.")
                .isNotNull();
        softly.assertThat(actualInternalColorDtos).as("입력받은 entity의 개수만큼 dto를 담고 있다.")
                .hasSize(2);
        softly.assertThat(actualInternalColorDtos.get(0).getName()).as("입력받은 entity의 정보를 가지고 있다.")
                .isEqualTo("Red");
        softly.assertThat(actualInternalColorDtos.get(1).getName()).as("입력받은 entity의 정보를 가지고 있다.")
                .isEqualTo("Blue");
    }

    private List<InternalColorEntity> generateInernalColorEntityList() {
        return List.of(
                InternalColorEntity.builder()
                        .id(1L)
                        .choiceRatio(0.3f)
                        .price(2000)
                        .fabricImage("fabric_image_url_1")
                        .internalImage("internal_image_url_1")
                        .name("Red")
                        .build(),
                InternalColorEntity.builder()
                        .id(2L)
                        .choiceRatio(0.2f)
                        .price(1500)
                        .fabricImage("fabric_image_url_2")
                        .internalImage("internal_image_url_2")
                        .name("Blue")
                        .build()
        );
    }

    @Test
    @DisplayName("트림의 가격 범위를 반환한다.")
    void findPriceRange() {
        //given
        Long trimId = 1L;
        long carId = 1L;
        when(trimMapper.findById(trimId)).thenReturn(TrimEntity.builder()
                .id(1L)
                .name("Trim A")
                .description("Description of Trim A")
                .price(50000)
                .carId(carId)
                .build());
        when(trimMapper.findMaximumComponentPrice(trimId)).thenReturn(20000);
        when(carMapper.findMaximumModelTypePrice(carId)).thenReturn(10000);
        when(carMapper.findMinimumModelTypePrice(carId)).thenReturn(0);
        PriceRangeDto expectedPriceRange = PriceRangeDto.of(20000 + 50000 + 10000, 50000);

        //when
        PriceRangeDto actualPriceRange = trimService.findPriceRange(trimId);

        //then
        assertThat(actualPriceRange).isEqualTo(expectedPriceRange);
    }
}
