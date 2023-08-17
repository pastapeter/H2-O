package com.h2o.h2oServer.domain.quotation.application;

import com.h2o.h2oServer.domain.car.exception.NoSuchCarException;
import com.h2o.h2oServer.domain.car.mapper.CarMapper;
import com.h2o.h2oServer.domain.model_type.dto.ModelTypeIdDto;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchBodyTypeException;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchDriveTrainException;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchPowertrainException;
import com.h2o.h2oServer.domain.model_type.mapper.BodytypeMapper;
import com.h2o.h2oServer.domain.model_type.mapper.DrivetrainMapper;
import com.h2o.h2oServer.domain.model_type.mapper.PowertrainMapper;
import com.h2o.h2oServer.domain.option.exception.NoSuchOptionException;
import com.h2o.h2oServer.domain.option.mapper.OptionMapper;
import com.h2o.h2oServer.domain.optionPackage.exception.NoSuchPackageException;
import com.h2o.h2oServer.domain.optionPackage.mapper.PackageMapper;
import com.h2o.h2oServer.domain.quotation.dto.QuotationRequestDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationResponseDto;
import com.h2o.h2oServer.domain.quotation.mapper.QuotationMapper;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchTrimException;
import com.h2o.h2oServer.domain.trim.mapper.TrimMapper;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.*;
import org.mockito.Mockito;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.when;

@MybatisTest
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
        quotationService = new QuotationService(quotationMapper,
                carMapper,
                trimMapper,
                powertrainMapper,
                bodytypeMapper,
                drivetrainMapper,
                optionMapper,
                packageMapper);
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
            assertThatThrownBy(() -> quotationService.saveQuotation(createMockRequest()))
                    .isInstanceOf(NoSuchCarException.class);
        }

        @Test
        @DisplayName("데이터베이스에 존재하지 않는 trim에 대한 요청일 경우, 예외를 발생시킨다.")
        void validateTrim() {
            //given
            when(trimMapper.checkIfTrimExists(5L)).thenReturn(false);

            //when
            //then
            assertThatThrownBy(() -> quotationService.saveQuotation(createMockRequest()))
                    .isInstanceOf(NoSuchTrimException.class);
        }

        @Test
        @DisplayName("데이터베이스에 존재하지 않는 powertrain에 대한 요청일 경우, 예외를 발생시킨다.")
        void validatePowertrain() {
            //given
            when(powertrainMapper.checkIfPowertrainExists(1L)).thenReturn(false);

            //when
            //then
            assertThatThrownBy(() -> quotationService.saveQuotation(createMockRequest()))
                    .isInstanceOf(NoSuchPowertrainException.class);
        }

        @Test
        @DisplayName("데이터베이스에 존재하지 않는 바디타입에 대한 요청일 경우, 예외를 발생시킨다.")
        void validateBodytype() {
            //given
            when(bodytypeMapper.checkIfBodytypeExists(2L)).thenReturn(false);

            //when
            //then
            assertThatThrownBy(() -> quotationService.saveQuotation(createMockRequest()))
                    .isInstanceOf(NoSuchBodyTypeException.class);
        }

        @Test
        @DisplayName("데이터베이스에 존재하지 않는 구동 방식에 대한 요청일 경우, 예외를 발생시킨다.")
        void validateDriveTrain() {
            //given
            when(drivetrainMapper.checkIfDrivetrainExists(3L)).thenReturn(false);

            //when
            //then
            assertThatThrownBy(() -> quotationService.saveQuotation(createMockRequest()))
                    .isInstanceOf(NoSuchDriveTrainException.class);
        }

        @Test
        @DisplayName("데이터베이스에 존재하지 않는 옵션에 대한 요청일 경우, 예외를 발생시킨다.")
        void validateOption() {
            //given
            when(optionMapper.checkIfOptionExists(8L)).thenReturn(false);

            //when
            //then
            assertThatThrownBy(() -> quotationService.saveQuotation(createMockRequest()))
                    .isInstanceOf(NoSuchOptionException.class);
        }

        @Test
        @DisplayName("데이터베이스에 존재하지 않는 패키지에 대한 요청일 경우, 예외를 발생시킨다.")
        void validatePackage() {
            //given
            when(packageMapper.checkIfPackageExists(11L)).thenReturn(false);

            //when
            //then
            assertThatThrownBy(() -> quotationService.saveQuotation(createMockRequest()))
                    .isInstanceOf(NoSuchPackageException.class);
        }
    }

//    @Test
//    @Sql("classpath:db/quotation/quotation-tx-data.sql")
//    @DisplayName("견적이 저장되지 못하면 롤백된다.")
//    void transaction() {
//        //given
//        QuotationRequestDto request = createMockRequest();
//
//        //when
//        QuotationResponseDto quotationResponseDto = quotationService.saveQuotation(request);
//
//        //then
//        softly.assertThat(quotationMapper.countQuotation())
//                .as("id 충돌로 인해 Quotation 테이블에 대한 롤백이 일어난다.")
//                .isEqualTo(0L);
//        softly.assertThat(quotationResponseDto)
//                .as("롤백되면 응답 객체가 생성되지 않는다.")
//                .isNull();
//        softly.assertAll();
//    }

    private QuotationRequestDto createMockRequest() {
        ModelTypeIdDto modelTypeId = new ModelTypeIdDto();
        modelTypeId.setPowertrainId(1L);
        modelTypeId.setBodytypeId(2L);
        modelTypeId.setDrivetrainId(3L);

        QuotationRequestDto request = new QuotationRequestDto();
        request.setCarId(4L);
        request.setTrimId(5L);
        request.setModelTypeIds(modelTypeId);
        request.setInternalColorId(6L);
        request.setExternalColorId(7L);
        request.setOptionIds(List.of(8L, 9L, 10L));
        request.setPackageIds(List.of(11L));

        return request;
    }
}
