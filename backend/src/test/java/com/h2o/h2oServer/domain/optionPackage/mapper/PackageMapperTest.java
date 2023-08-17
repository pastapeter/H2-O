package com.h2o.h2oServer.domain.optionPackage.mapper;

import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.option.entity.enums.HashTag;
import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import com.h2o.h2oServer.domain.optionPackage.entity.PackageEntity;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@MybatisTest
class PackageMapperTest {

    @Autowired
    PackageMapper packageMapper;
    SoftAssertions softly = new SoftAssertions();

    @Test
    @DisplayName("존재하는 trim, package에 대해서 유효한 PackageEntity 객체를 반환한다.")
    @Sql("classpath:db/optionPackage/package-data.sql")
    void findPackage() {
        //given
        Long packageId = 1L;
        Long trimId = 2L;
        PackageEntity expectedPackageEntity = PackageEntity.builder()
                .name("Package 1")
                .category(OptionCategory.DETAILED_ITEM)
                .choiceRatio(0.7f)
                .price(500)
                .build();

        //when
        PackageEntity actualPackageEntity = packageMapper.findPackage(trimId, packageId);

        //then
        softly.assertThat(actualPackageEntity).as("유효한 데이터가 매핑되었는지 확인").isNotNull();
        softly.assertThat(actualPackageEntity).as("데이터베이스에 존재하는 데이터인지 확인").isEqualTo(expectedPackageEntity);
        softly.assertAll();
    }

    @Test
    @DisplayName("존재하는 package에 대해서 유효한 HashTagEntity 객체를 반환한다.")
    @Sql("classpath:db/optionPackage/package-hashtag-data.sql")
    void findHashTag() {
        //given
        Long packageId = 1L;
        List<HashTagEntity> expectedHashTagEntities = List.of(
                HashTagEntity.builder()
                        .name(HashTag.CAMPING)
                        .build(),
                HashTagEntity.builder()
                        .name(HashTag.LEISURE)
                        .build(),
                HashTagEntity.builder()
                        .name(HashTag.SPORTS)
                        .build()
        );
        //when
        List<HashTagEntity> actualHashTagEntities = packageMapper.findHashTag(packageId);

        //then
        softly.assertThat(actualHashTagEntities).as("유효한 데이터가 매핑되었는지 확인").isNotEmpty();
        softly.assertThat(actualHashTagEntities).as("packageId에 해당하는 HashTagEntity 객체가 모두 매핑되었는지 확인")
                .contains(expectedHashTagEntities.get(0))
                .contains(expectedHashTagEntities.get(1))
                .contains(expectedHashTagEntities.get(2));
        softly.assertAll();
    }

    @Test
    @DisplayName("존재하는 패키지인 경우 true를 반환한다.")
    @Sql("classpath:db/optionPackage/package-data.sql")
    void checkIfPackageExists() {
        //given
        Long id = 1L;

        //when
        Boolean isExists = packageMapper.checkIfPackageExists(id);

        //then
        assertThat(isExists).isTrue();
    }

    @Test
    @DisplayName("존재하지 않는 패키지인 경우 false를 반환한다.")
    @Sql("classpath:db/optionPackage/package-data.sql")
    void checkIfPackageExistsFalse() {
        //given
        Long id = 5L;

        //when
        Boolean isExists = packageMapper.checkIfPackageExists(id);

        //then
        assertThat(isExists).isFalse();
    }
}
