package com.h2o.h2oServer.domain.trim.application;

import com.h2o.h2oServer.domain.trim.dto.TrimDto;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@Sql("classpath:db/trims-data.sql")
class TrimServiceTest {

    @Autowired
    private TrimService trimService;
    private SoftAssertions softly;

    @BeforeEach
    void setUp() {
        softly = new SoftAssertions();
    }
    
    @Test
    @DisplayName("존재하는 vehicle에 대한 요청인 경우 Dto로 formatting해서 반환한다.")
    void findTrimInformation() {
        //given
        Long vehicleId = 1L;

        //when
        List<TrimDto> actualTrimDtos = trimService.findTrimInformation(vehicleId);

        //then
        softly.assertThat(actualTrimDtos).as("null이 아니다.").isNotNull();
        softly.assertThat(actualTrimDtos).as("TrimDto를 포함한다.").isNotEmpty();
        softly.assertThat(actualTrimDtos.get(0).getImages()).as("Images를 포함한다.").isNotNull();
        softly.assertThat(actualTrimDtos.get(0).getOptions()).as("Options를 포함한다.").isNotNull();
    }

    @Test
    @DisplayName("존재하지 않는 vehicle에 대한 요청인 경우 빈 Dto를 반한환다.")
    void findTrimInformationNotExist() {
        //given
        Long vehicleId = Long.MAX_VALUE;

        //when
        List<TrimDto> actualTrimDtos = trimService.findTrimInformation(vehicleId);

        //then
        softly.assertThat(actualTrimDtos).as("null이 아니다.").isNotNull();
        softly.assertThat(actualTrimDtos).as("TrimDto를 포함하지 않는다.").isEmpty();
    }
}
