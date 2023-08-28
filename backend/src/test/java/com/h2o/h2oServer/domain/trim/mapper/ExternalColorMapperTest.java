package com.h2o.h2oServer.domain.trim.mapper;

import com.h2o.h2oServer.domain.trim.ImageFixture;
import com.h2o.h2oServer.domain.trim.entity.ImageEntity;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;

@MybatisTest
class ExternalColorMapperTest {

    @Autowired
    ExternalColorMapper externalColorMapper;

    private SoftAssertions softly;

    @BeforeEach
    void setup() {
        softly = new SoftAssertions();
    }

    @Test
    @DisplayName("존재하는 외부 색상에 대해서 해당하는 정보를 ImageEntity로 반환한다.")
    @Sql("classpath:db/image-data.sql")
    void findImages() {
        //given
        Long externalColorId = 1L;
        List<ImageEntity> expectedImageEntities = ImageFixture.generateImageEntityList();

        //when
        List<ImageEntity> actualImageEntities = externalColorMapper.findImages(externalColorId);

        //then
        softly.assertThat(actualImageEntities).as("유효한 데이터만 매핑되었는지 확인").hasSize(2);
        softly.assertThat(actualImageEntities).as("externalColorId에 해당하는 객체가 모두 매핑되었는지 확인")
                .containsAll(expectedImageEntities);

        softly.assertAll();
    }
}
