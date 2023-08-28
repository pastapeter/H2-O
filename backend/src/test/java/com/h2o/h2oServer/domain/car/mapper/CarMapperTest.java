package com.h2o.h2oServer.domain.car.mapper;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.jdbc.Sql;

import static org.assertj.core.api.Assertions.assertThat;

@MybatisTest
class CarMapperTest {

    @Autowired
    CarMapper carMapper;

    @Test
    @DisplayName("car modelType의 최대 가격을 반환한다.")
    @Sql("classpath:db/car/car-modeltype-data.sql")
    void findMaximumModelTypePrice() {
        //given
        Long carId = 1L;
        Integer expectedPrice = 340000;

        //when
        Integer actualPrice = carMapper.findMaximumModelTypePrice(carId);

        //then
        assertThat(actualPrice).isEqualTo(expectedPrice);
    }

    @Test
    @DisplayName("car modelType의 최소 가격을 반환한다.")
    @Sql("classpath:db/car/car-modeltype-data.sql")
    void findMinimumModelTypePrice() {
        //given
        Long carId = 1L;
        Integer expectedPrice = 120000;

        //when
        Integer actualPrice = carMapper.findMinimumModelTypePrice(carId);

        //then
        assertThat(actualPrice).isEqualTo(expectedPrice);
    }

    @Test
    @DisplayName("존재하는 차량인 경우 true를 반환한다.")
    @Sql("classpath:db/car/car-data.sql")
    void checkIfCarExists() {
        //given
        Long carId = 1L;

        //when
        boolean isExists = carMapper.checkIfCarExists(carId);

        //then
        assertThat(isExists).isTrue();
    }

    @Test
    @DisplayName("존재하지 않는 차량인 경우 false를 반환한다.")
    @Sql("classpath:db/car/car-data.sql")
    void checkIfCarExistsFalse() {
        //given
        Long carId = 4L;

        //when
        boolean isExists = carMapper.checkIfCarExists(carId);

        //then
        assertThat(isExists).isFalse();
    }
}
