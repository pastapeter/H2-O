package com.h2o.h2oServer.domain.optionPackage.mapper;

import com.h2o.h2oServer.domain.option.HashTagFixture;
import com.h2o.h2oServer.domain.option.entity.HashTagEntity;
import com.h2o.h2oServer.domain.optionPackage.PackageFixture;
import com.h2o.h2oServer.domain.optionPackage.entity.PackageEntity;
import org.assertj.core.api.SoftAssertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.jdbc.Sql;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

@MybatisTest
class PackageMapperTest {

    @Autowired
    PackageMapper packageMapper;
    SoftAssertions softly = new SoftAssertions();

    @Nested
    @DisplayName("패키지 조회 테스트")
    @Sql("classpath:db/optionPackage/package-data.sql")
    class findPackageTest {
        @Test
        @DisplayName("존재하는 trim, package에 대해서 유효한 PackageEntity 객체를 반환한다.")
        void findPackage() {
            //given
            Long packageId = 1L;
            Long trimId = 2L;
            PackageEntity expectedPackageEntity = PackageFixture.generatePackageEntity();

            //when
            PackageEntity actualPackageEntity = packageMapper.findPackage(trimId, packageId).get();

            //then
            softly.assertThat(actualPackageEntity).as("유효한 데이터가 매핑되었는지 확인").isNotNull();
            softly.assertThat(actualPackageEntity).as("데이터베이스에 존재하는 데이터인지 확인").isEqualTo(expectedPackageEntity);
            softly.assertAll();
        }

        @Test
        @DisplayName("존재하지 않는 package에 대해서 null을 반환한다.")
        void findPackageNotExists() {
            //given
            Long packageId = 4L;
            Long trimId = 2L;

            //when
            Optional<PackageEntity> actualPackageEntity = packageMapper.findPackage(trimId, packageId);

            //then
            assertThat(actualPackageEntity).isEmpty();
        }
    }


    @Nested
    @DisplayName("패키지 해시태그 조회 테스트")
    @Sql("classpath:db/optionPackage/package-hashtag-data.sql")
    class findHashTagTest {
        @Test
        @DisplayName("존재하는 package에 대해서 유효한 HashTagEntity 객체를 반환한다.")
        void findHashTag() {
            //given
            Long packageId = 1L;
            List<HashTagEntity> expectedHashTagEntities = HashTagFixture.generateHashTagEntities();

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
        @DisplayName("존재하지 않는 package에 대해서 null을 반환한다.")
        void findHashTagPackageNotExists() {
            //given
            Long packageId = 5L;

            //when
            List<HashTagEntity> actualHashTagEntities = packageMapper.findHashTag(packageId);

            //then
            assertThat(actualHashTagEntities).isEmpty();
        }
    }

    @Nested
    @DisplayName("존재 여부 확인 쿼리 테스트")
    @Sql("classpath:db/optionPackage/package-data.sql")
    class CheckIfPackageExists {
        @Test
        @DisplayName("존재하는 패키지인 경우 true를 반환한다.")
        void checkIfPackageExists() {
            //given
            Long id = 1L;

            //when
            boolean isExists = packageMapper.checkIfPackageExists(id);

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
            boolean isExists = packageMapper.checkIfPackageExists(id);

            //then
            assertThat(isExists).isFalse();
        }
    }

}
