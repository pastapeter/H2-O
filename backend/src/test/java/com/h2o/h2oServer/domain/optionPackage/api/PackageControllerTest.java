package com.h2o.h2oServer.domain.optionPackage.api;

import com.h2o.h2oServer.domain.option.HashTagFixture;
import com.h2o.h2oServer.domain.option.OptionFixture;
import com.h2o.h2oServer.domain.optionPackage.PackageFixture;
import com.h2o.h2oServer.domain.optionPackage.application.PackageService;
import com.h2o.h2oServer.domain.optionPackage.dto.PackageDetailsDto;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchTrimException;
import com.h2o.h2oServer.global.config.RedisConfig;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(controllers = PackageController.class)
@AutoConfigureMockMvc
@Import(RedisConfig.class)
class PackageControllerTest {

    @Autowired
    MockMvc mockMvc;
    @MockBean
    PackageService packageService;

    @Nested
    @DisplayName("패키지 세부 정보 조회 테스트")
    class GetPackageInformationTest {
        @Test
        @DisplayName("존재하는 trim 요청에 대해서 InternalColorDto를 응답한다.")
        void withValidTrimId() throws Exception {
            // given
            Long trimId = 1L;
            Long packageId = 1L;

            PackageDetailsDto expectedPackageDetailsDto = PackageDetailsDto.of(PackageFixture.generatePackageEntity(),
                    HashTagFixture.generateHashTagEntities(),
                    OptionFixture.generateOptionDtoList());

            when(packageService.findPackageInformation(trimId, packageId)).thenReturn(expectedPackageDetailsDto);

            // when
            mockMvc.perform(get("/trim/{trimId}/package/{packageId}", trimId, packageId))
                    //then
                    .andDo(print())
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.name").value(expectedPackageDetailsDto.getName()))
                    .andExpect(jsonPath("$.category").value(expectedPackageDetailsDto.getCategory()))
                    .andExpect(jsonPath("$.price").value(expectedPackageDetailsDto.getPrice()))
                    .andExpect(jsonPath("$.choiceRatio").value(expectedPackageDetailsDto.getChoiceRatio()))
                    .andExpect(jsonPath("$.choiceCount").value(expectedPackageDetailsDto.getChoiceCount()))
                    .andExpect(jsonPath("$.isOverHalf").value(expectedPackageDetailsDto.getIsOverHalf()))
                    .andExpect(jsonPath("$.hashTags").isArray())
                    .andExpect(jsonPath("$.hashTags.length()").value(expectedPackageDetailsDto.getHashTags().size()))
                    .andExpect(jsonPath("$.hashTags[0]").value(expectedPackageDetailsDto.getHashTags().get(0)))
                    .andExpect(jsonPath("$.hashTags[1]").value(expectedPackageDetailsDto.getHashTags().get(1)))
                    .andExpect(jsonPath("$.components").isArray())
                    .andExpect(jsonPath("$.components.length()").value(expectedPackageDetailsDto.getComponents().size()))
                    .andExpect(jsonPath("$.components[1].name").value(expectedPackageDetailsDto.getComponents().get(1).getName()));
        }

        @Test
        @DisplayName("존재하지 않는 trim 요청에 대해서 NotFound로 응답한다.")
        void withInvalidTrim() throws Exception {
            //given
            Long trimId = 1L;
            Long packageId = 1L;

            when(packageService.findPackageInformation(trimId, packageId)).thenThrow(new NoSuchTrimException());
            // todo : packageId, trimId 중 어느 쪽이 유효하지 않은 지 구분하는 테스트 코드

            //when
            mockMvc.perform(get("/trim/{trimId}/package/{packageId}", trimId, packageId))
                    //then
                    .andDo(print())
                    .andExpect(status().isNotFound());
        }
    }
}
