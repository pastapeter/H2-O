package com.h2o.h2oServer.domain.quotation.application;

import com.h2o.h2oServer.domain.quotation.dto.QuotationRequestDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationResponseDto;
import com.h2o.h2oServer.domain.quotation.mapper.QuotationMapper;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.transaction.annotation.Transactional;

import static com.h2o.h2oServer.domain.quotation.QuotationFixture.generateQuotationRequestDto;

@SpringBootTest
public class QuotationServiceTransactionTest {
    private static SoftAssertions softly;

    @Autowired
    private QuotationService quotationService;
    @Autowired
    private QuotationMapper quotationMapper;

    @BeforeAll
    static void setUp() {
        softly = new SoftAssertions();
    }

    @Test
    @DisplayName("견적 저장 성공 시 quotation, options_quotation, package_quotation 테이블에 데이터가 저장된다.")
    @Sql("classpath:db/quotation/tx_data.sql")
    @Transactional
    void saveQuotation() {
        //given
        QuotationRequestDto request = generateQuotationRequestDto();

        //when
        QuotationResponseDto response = quotationService.saveQuotation(request);

        //then
        softly.assertThat(response.getQuotationId())
                .isEqualTo(1L);
        softly.assertThat(quotationMapper.countQuotation())
                .isEqualTo(1L);
        softly.assertThat(quotationMapper.countOptionQuotation())
                .isEqualTo(3L);
        softly.assertThat(quotationMapper.countPackageQuotation())
                .isEqualTo(1L);
        softly.assertAll();
    }
}
