package com.h2o.h2oServer.domain.quotation.application;

import com.h2o.h2oServer.domain.model_type.dto.ModelTypeIdDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationRequestDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationResponseDto;
import com.h2o.h2oServer.domain.quotation.mapper.QuotationMapper;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;

@MybatisTest
class QuotationServiceTest {

    private QuotationMapper quotationMapper;
    private QuotationService quotationService;
    private SoftAssertions softly;

    @BeforeEach
    void setUp() {
        quotationMapper = Mockito.mock(QuotationMapper.class);
        quotationService = Mockito.mock(QuotationService.class);
        softly = new SoftAssertions();
    }

    @Test
    @Sql("classpath:db/quotation/quotation-tx-data.sql")
    @DisplayName("견적이 저장되지 못하면 롤백된다.")
    void transaction () {
        //given
        QuotationRequestDto request = createMockRequest();

        //when
        QuotationResponseDto quotationResponseDto = quotationService.saveQuotation(request);

        //then
        softly.assertThat(quotationMapper.countQuotation())
                .as("id 충돌로 인해 Quotation 테이블에 대한 롤백이 일어난다.")
                .isEqualTo(0L);
        softly.assertThat(quotationResponseDto)
                .as("롤백되면 응답 객체가 생성되지 않는다.")
                .isNull();
        softly.assertAll();
    }

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
