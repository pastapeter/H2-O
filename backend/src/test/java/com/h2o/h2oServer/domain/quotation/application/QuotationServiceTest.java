package com.h2o.h2oServer.domain.quotation.application;

import com.h2o.h2oServer.domain.car.exception.NoSuchCarException;
import com.h2o.h2oServer.domain.car.mapper.CarMapper;
import com.h2o.h2oServer.domain.model_type.BodytypeFixture;
import com.h2o.h2oServer.domain.model_type.DrivetrainFixture;
import com.h2o.h2oServer.domain.model_type.PowertrainFixture;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchBodyTypeException;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchDriveTrainException;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchPowertrainException;
import com.h2o.h2oServer.domain.model_type.mapper.BodytypeMapper;
import com.h2o.h2oServer.domain.model_type.mapper.DrivetrainMapper;
import com.h2o.h2oServer.domain.model_type.mapper.PowertrainMapper;
import com.h2o.h2oServer.domain.option.HashTagFixture;
import com.h2o.h2oServer.domain.option.OptionFixture;
import com.h2o.h2oServer.domain.option.entity.enums.HashTag;
import com.h2o.h2oServer.domain.option.exception.NoSuchOptionException;
import com.h2o.h2oServer.domain.option.mapper.OptionMapper;
import com.h2o.h2oServer.domain.optionPackage.exception.NoSuchPackageException;
import com.h2o.h2oServer.domain.optionPackage.mapper.PackageMapper;
import com.h2o.h2oServer.domain.quotation.dto.*;
import com.h2o.h2oServer.domain.quotation.entity.ReleaseEntity;
import com.h2o.h2oServer.domain.quotation.mapper.QuotationMapper;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchTrimException;
import com.h2o.h2oServer.domain.trim.ImageFixture;
import com.h2o.h2oServer.domain.trim.mapper.ExternalColorMapper;
import com.h2o.h2oServer.domain.trim.mapper.TrimMapper;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.*;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.Optional;

import static com.h2o.h2oServer.domain.option.HashTagFixture.generateHashTagEntities;
import static com.h2o.h2oServer.domain.quotation.QuotationFixture.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.ArgumentMatchers.anyMap;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.when;

@SpringBootTest
class QuotationServiceTest {

    private static QuotationMapper quotationMapper;
    private static CarMapper carMapper;
    private static TrimMapper trimMapper;
    private static PowertrainMapper powertrainMapper;
    private static BodytypeMapper bodytypeMapper;
    private static DrivetrainMapper drivetrainMapper;
    private static OptionMapper optionMapper;
    private static PackageMapper packageMapper;
    private static QuotationService quotationService;
    private static ExternalColorMapper externalColorMapper;
    private static CosineSimilarityCalculator cosineSimilarityCalculator;
    private static SoftAssertions softly;

    @BeforeAll
    static void setUp() {
        quotationMapper = Mockito.mock(QuotationMapper.class);
        carMapper = Mockito.mock(CarMapper.class);
        trimMapper = Mockito.mock(TrimMapper.class);
        powertrainMapper = Mockito.mock(PowertrainMapper.class);
        bodytypeMapper = Mockito.mock(BodytypeMapper.class);
        drivetrainMapper = Mockito.mock(DrivetrainMapper.class);
        optionMapper = Mockito.mock(OptionMapper.class);
        packageMapper = Mockito.mock(PackageMapper.class);
        externalColorMapper = Mockito.mock(ExternalColorMapper.class);
        cosineSimilarityCalculator = Mockito.mock(CosineSimilarityCalculator.class);

        quotationService = new QuotationService(quotationMapper,
                carMapper,
                trimMapper,
                powertrainMapper,
                bodytypeMapper,
                drivetrainMapper,
                optionMapper,
                packageMapper,
                externalColorMapper,
                cosineSimilarityCalculator);
        softly = new SoftAssertions();
    }

    @Nested
    @DisplayName("validation test")
    class validation {

        @BeforeEach
        void setup() {
            when(carMapper.checkIfCarExists(4L)).thenReturn(true);
            when(trimMapper.checkIfTrimExists(5L)).thenReturn(true);
            when(powertrainMapper.checkIfPowertrainExists(1L)).thenReturn(true);
            when(bodytypeMapper.checkIfBodytypeExists(2L)).thenReturn(true);
            when(drivetrainMapper.checkIfDrivetrainExists(3L)).thenReturn(true);
            when(optionMapper.checkIfOptionExists(8L)).thenReturn(true);
            when(optionMapper.checkIfOptionExists(9L)).thenReturn(true);
            when(optionMapper.checkIfOptionExists(10L)).thenReturn(true);
            when(packageMapper.checkIfPackageExists(11L)).thenReturn(true);
        }

        @Test
        @DisplayName("데이터베이스에 존재하지 않는 car에 대한 요청일 경우, 예외를 발생시킨다.")
        void validateCar() {
            //given
            when(carMapper.checkIfCarExists(4L)).thenReturn(false);

            //when
            //then
            assertThatThrownBy(() -> quotationService.saveQuotation(generateQuotationRequestDto()))
                    .isInstanceOf(NoSuchCarException.class);
        }

        @Test
        @DisplayName("데이터베이스에 존재하지 않는 trim에 대한 요청일 경우, 예외를 발생시킨다.")
        void validateTrim() {
            //given
            when(trimMapper.checkIfTrimExists(5L)).thenReturn(false);

            //when
            //then
            assertThatThrownBy(() -> quotationService.saveQuotation(generateQuotationRequestDto()))
                    .isInstanceOf(NoSuchTrimException.class);
        }

        @Test
        @DisplayName("데이터베이스에 존재하지 않는 powertrain에 대한 요청일 경우, 예외를 발생시킨다.")
        void validatePowertrain() {
            //given
            when(powertrainMapper.checkIfPowertrainExists(1L)).thenReturn(false);

            //when
            //then
            assertThatThrownBy(() -> quotationService.saveQuotation(generateQuotationRequestDto()))
                    .isInstanceOf(NoSuchPowertrainException.class);
        }

        @Test
        @DisplayName("데이터베이스에 존재하지 않는 바디타입에 대한 요청일 경우, 예외를 발생시킨다.")
        void validateBodytype() {
            //given
            when(bodytypeMapper.checkIfBodytypeExists(2L)).thenReturn(false);

            //when
            //then
            assertThatThrownBy(() -> quotationService.saveQuotation(generateQuotationRequestDto()))
                    .isInstanceOf(NoSuchBodyTypeException.class);
        }

        @Test
        @DisplayName("데이터베이스에 존재하지 않는 구동 방식에 대한 요청일 경우, 예외를 발생시킨다.")
        void validateDriveTrain() {
            //given
            when(drivetrainMapper.checkIfDrivetrainExists(3L)).thenReturn(false);

            //when
            //then
            assertThatThrownBy(() -> quotationService.saveQuotation(generateQuotationRequestDto()))
                    .isInstanceOf(NoSuchDriveTrainException.class);
        }

        @Test
        @DisplayName("데이터베이스에 존재하지 않는 옵션에 대한 요청일 경우, 예외를 발생시킨다.")
        void validateOption() {
            //given
            when(optionMapper.checkIfOptionExists(8L)).thenReturn(false);

            //when
            //then
            assertThatThrownBy(() -> quotationService.saveQuotation(generateQuotationRequestDto()))
                    .isInstanceOf(NoSuchOptionException.class);
        }

        @Test
        @DisplayName("데이터베이스에 존재하지 않는 패키지에 대한 요청일 경우, 예외를 발생시킨다.")
        void validatePackage() {
            //given
            when(packageMapper.checkIfPackageExists(11L)).thenReturn(false);

            //when
            //then
            assertThatThrownBy(() -> quotationService.saveQuotation(generateQuotationRequestDto()))
                    .isInstanceOf(NoSuchPackageException.class);
        }

    }
    
    @Nested
    @DisplayName("유사 견적 추천 기능 테스트")
    class findSimilarQuotationTest {

        private QuotationRequestDto quotationRequestDto;

        @BeforeEach
        void setup() {
            quotationRequestDto = generateQuotationRequestDto();

            when(quotationMapper.findReleaseQuotationWithVolume(quotationRequestDto.getTrimId()))
                    .thenReturn(generateReleaseEntityList());
            when(packageMapper.findHashTag(11L))
                    .thenReturn(generateHashTagEntities());
            when(packageMapper.findHashTag(12L))
                    .thenReturn(generateHashTagEntities(List.of(HashTag.LEISURE, HashTag.LEISURE)));
            when(optionMapper.findHashTag(8L))
                    .thenReturn(HashTagFixture.generateHashTagEntities(List.of(HashTag.COMMUTE, HashTag.COMFORTABLE)));
            when(optionMapper.findHashTag(9L))
                    .thenReturn(HashTagFixture.generateHashTagEntities(List.of(HashTag.MALE, HashTag.CHILD_COMMUTE, HashTag.STYLE)));
            when(optionMapper.findHashTag(10L))
                    .thenReturn(HashTagFixture.generateHashTagEntities(List.of(HashTag.STYLE, HashTag.STYLE, HashTag.COUPLE)));
            when(optionMapper.findHashTag(11L))
                    .thenReturn(HashTagFixture.generateHashTagEntities(List.of(HashTag.COMMUTE, HashTag.COMFORTABLE)));
            when(powertrainMapper.findById(1L)).thenReturn(PowertrainFixture.generatePowertrainEntity());
            when(bodytypeMapper.findById(1L)).thenReturn(BodytypeFixture.generateBodytypeEntity());
            when(drivetrainMapper.findById(1L)).thenReturn(DrivetrainFixture.generateDrivetrainEntity());
            when(externalColorMapper.findImages(1L)).thenReturn(ImageFixture.generateExternalImageEntityList());
            when(optionMapper.findOptionDetails(anyLong(), anyLong())).thenReturn(Optional.of(OptionFixture.generateOptionDetailsEntity()));
        }

        @Test
        @DisplayName("유사 견적을 추천한다.")
        void findSimilarQuotation() {
            //given
            when(cosineSimilarityCalculator.calculateCosineSimilarity(anyMap(), anyMap())).thenReturn(0.7);

            //when
            List<SimilarQuotationDto> actualSimilarQuotationDto = quotationService.findSimilarQuotations(quotationRequestDto);

            //then
            softly.assertThat(actualSimilarQuotationDto.size()).isEqualTo(1);
            SimilarQuotationDto similarQuotationDto = actualSimilarQuotationDto.get(0);
            softly.assertThat(similarQuotationDto.getImage()).isEqualTo("url1");
            softly.assertThat(similarQuotationDto.getPrice()).isEqualTo(20);
            softly.assertAll();
        }

        @Test
        @DisplayName("유사도가 < 20%, > 90%인 경우는 추천하지 않는다.")
        void withSimilarityOutOfBound() {
            //given

            when(quotationMapper.findReleaseQuotationWithVolume(quotationRequestDto.getTrimId()))
                    .thenReturn(List.of(
                            ReleaseEntity.builder()
                                    .packageCombination("11,12")
                                    .optionCombination("8,9,10,12")
                                    .quotationCount(32)
                                    .price(10)
                                    .trimId(5L)
                                    .externalColorId(1L)
                                    .internalColorId(3L)
                                    .drivetrainId(1L)
                                    .bodytypeId(1L)
                                    .powertrainId(1L)
                                    .build(),
                            ReleaseEntity.builder()
                                    .packageCombination("11")
                                    .optionCombination("8,9,11")
                                    .quotationCount(32)
                                    .price(20)
                                    .trimId(5L)
                                    .externalColorId(1L)
                                    .internalColorId(3L)
                                    .drivetrainId(1L)
                                    .bodytypeId(1L)
                                    .powertrainId(1L)
                                    .build()
                    ));
            when(optionMapper.findHashTag(12L))
                    .thenReturn(HashTagFixture.generateHashTagEntities(List.of(HashTag.COMMUTE, HashTag.COMFORTABLE)));
            when(cosineSimilarityCalculator.calculateCosineSimilarity(anyMap(), anyMap())).thenReturn(0.1);

            //when
            List<SimilarQuotationDto> actualSimilarQuotationDto = quotationService.findSimilarQuotations(quotationRequestDto);

            //then
            assertThat(actualSimilarQuotationDto.size()).isEqualTo(0);
        }

        @Test
        @DisplayName("요청 견적보다 추가 견적이 없는 경우 추천하지 않는다.")
        void withoutAdditionalOptions() {
            //given
            when(quotationMapper.findReleaseQuotationWithVolume(quotationRequestDto.getTrimId()))
                    .thenReturn(List.of(
                            ReleaseEntity.builder()
                                    .packageCombination("11,12")
                                    .optionCombination("8,9")
                                    .quotationCount(32)
                                    .price(10)
                                    .trimId(5L)
                                    .externalColorId(1L)
                                    .internalColorId(3L)
                                    .drivetrainId(1L)
                                    .bodytypeId(1L)
                                    .powertrainId(1L)
                                    .build(),
                            ReleaseEntity.builder()
                                    .packageCombination("11")
                                    .optionCombination("8,10")
                                    .quotationCount(32)
                                    .price(20)
                                    .trimId(5L)
                                    .externalColorId(1L)
                                    .internalColorId(3L)
                                    .drivetrainId(1L)
                                    .bodytypeId(1L)
                                    .powertrainId(1L)
                                    .build()
                    ));
            when(cosineSimilarityCalculator.calculateCosineSimilarity(anyMap(), anyMap())).thenReturn(0.7);

            //when
            List<SimilarQuotationDto> actualSimilarQuotationDto = quotationService.findSimilarQuotations(quotationRequestDto);

            //then
            assertThat(actualSimilarQuotationDto.size()).isEqualTo(0);
        }
    }

    @Test
    @DisplayName("요청받은 견적의 출고 대수를 반환한다.")
    void findNumberOfIdenticalQuotations() {
        //given
        QuotationRequestDto requestDto = generateQuotationRequestDto();
        String optionCombination = "8,9,10";
        String packageCombination = "11";
        when(quotationMapper.findIdenticalQuotations(QuotationDto.of(requestDto),
                optionCombination,
                packageCombination))
                .thenReturn(List.of("mock1", "mock2"));
        QuotationCountDto expectedQuotationCountDto = QuotationCountDto.builder()
                .salesCount(2)
                .build();

        //when
        QuotationCountDto actualQuotationCountDto = quotationService.findNumberOfIdenticalQuotations(requestDto);

        //then
        assertThat(actualQuotationCountDto).isEqualTo(expectedQuotationCountDto);
    }
}
