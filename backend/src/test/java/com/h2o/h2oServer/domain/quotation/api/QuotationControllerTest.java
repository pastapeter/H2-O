package com.h2o.h2oServer.domain.quotation.api;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.h2o.h2oServer.domain.car.exception.NoSuchCarException;
import com.h2o.h2oServer.domain.model_type.dto.ModelTypeNameDto;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchBodyTypeException;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchDriveTrainException;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchPowertrainException;
import com.h2o.h2oServer.domain.option.dto.OptionSummaryDto;
import com.h2o.h2oServer.domain.option.exception.NoSuchOptionException;
import com.h2o.h2oServer.domain.optionPackage.exception.NoSuchPackageException;
import com.h2o.h2oServer.domain.quotation.QuotationFixture;
import com.h2o.h2oServer.domain.quotation.application.QuotationService;
import com.h2o.h2oServer.domain.quotation.dto.QuotationRequestDto;
import com.h2o.h2oServer.domain.quotation.dto.QuotationResponseDto;
import com.h2o.h2oServer.domain.quotation.dto.SimilarQuotationDto;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchTrimException;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(controllers = QuotationController.class)
@AutoConfigureMockMvc
class QuotationControllerTest {

    @Autowired
    private MockMvc mockMvc;
    @Autowired
    ObjectMapper objectMapper;
    @MockBean
    QuotationService quotationService;

    @Nested
    @DisplayName("견적 저장 테스트")
    class SaveQuotationTest {
        @Test
        @DisplayName("유효한 요청에 대해서 CREATED를 응답한다.")
        void withValidRequest() throws Exception {
            //given
            long expectedId = 1L;
            QuotationRequestDto requestDto = QuotationFixture.generateQuotationRequestDto();
            String jsonBody = objectMapper.writeValueAsString(requestDto);
            when(quotationService.saveQuotation(requestDto)).thenReturn(QuotationResponseDto.of(expectedId));

            //when
            mockMvc.perform(post("/quotation")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(jsonBody))
                    //then
                    .andDo(print())
                    .andExpect(status().isCreated())
                    .andExpect(jsonPath("$.quotationId").value(expectedId));
        }

        @ParameterizedTest
        @DisplayName("유효하지 않은 id를 포함하는 경우 NotFound로 응답한다.")
        @ValueSource(classes = {
                NoSuchPackageException.class,
                NoSuchDriveTrainException.class,
                NoSuchPowertrainException.class,
                NoSuchBodyTypeException.class,
                NoSuchCarException.class,
                NoSuchTrimException.class,
                NoSuchOptionException.class,
                NoSuchPackageException.class
        })        void withInvalidRequest(Class<? extends RuntimeException> exceptionType) throws Exception {
            //given
            QuotationRequestDto requestDto = QuotationFixture.generateQuotationRequestDto();
            String jsonBody = objectMapper.writeValueAsString(requestDto);
            when(quotationService.saveQuotation(requestDto)).thenThrow(exceptionType);

            //when
            mockMvc.perform(post("/quotation")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(jsonBody))
                    //then
                    .andExpect(status().isNotFound());
        }
    }

    @Nested
    @DisplayName("유사 견적 조회 테스트")
    class getSimilarQuotationsTest {
        @Test
        @DisplayName("유효한 요청에 대해서 유사 견적을 응답한다.")
        void withValidRequest() throws Exception {
            //given
            QuotationRequestDto requestDto = QuotationFixture.generateQuotationRequestDto();
            String jsonBody = objectMapper.writeValueAsString(requestDto);
            List<SimilarQuotationDto> similarQuotationDtos = generateSimilarQuotationDtoList();
            when(quotationService.findSimilarQuotations(requestDto)).thenReturn(similarQuotationDtos);

            //when
            mockMvc.perform(post("/quotation/similar")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(jsonBody))
                    //then
                    .andDo(print())
                    .andExpect(status().isOk())
                    .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                    .andExpect(jsonPath("$").isArray())
                    .andExpect(jsonPath("$.length()").value(similarQuotationDtos.size()))
                    .andExpect(jsonPath("$[0].modelType.powertrainName").value(similarQuotationDtos.get(0).getModelType().getPowertrainName()))
                    .andExpect(jsonPath("$[0].modelType.bodytypeName").value(similarQuotationDtos.get(0).getModelType().getBodytypeName()))
                    .andExpect(jsonPath("$[0].modelType.drivetrainName").value(similarQuotationDtos.get(0).getModelType().getDrivetrainName()))
                    .andExpect(jsonPath("$[0].image").value(similarQuotationDtos.get(0).getImage()))
                    .andExpect(jsonPath("$[0].price").value(similarQuotationDtos.get(0).getPrice()))
                    .andExpect(jsonPath("$[0].options").isArray())
                    .andExpect(jsonPath("$[0].options.length()").value(similarQuotationDtos.get(0).getOptions().size()))
                    .andExpect(jsonPath("$[0].options[0].id").value(similarQuotationDtos.get(0).getOptions().get(0).getId()))
                    .andExpect(jsonPath("$[0].options[0].name").value(similarQuotationDtos.get(0).getOptions().get(0).getName()))
                    .andExpect(jsonPath("$[0].options[0].category").value(similarQuotationDtos.get(0).getOptions().get(0).getCategory()))
                    .andExpect(jsonPath("$[0].options[0].image").value(similarQuotationDtos.get(0).getOptions().get(0).getImage()))
                    .andExpect(jsonPath("$[0].options[0].price").value(similarQuotationDtos.get(0).getOptions().get(0).getPrice()))
                    .andExpect(jsonPath("$[0].options[1].id").value(similarQuotationDtos.get(0).getOptions().get(1).getId()))
                    .andExpect(jsonPath("$[0].options[1].name").value(similarQuotationDtos.get(0).getOptions().get(1).getName()))
                    .andExpect(jsonPath("$[0].options[1].category").value(similarQuotationDtos.get(0).getOptions().get(1).getCategory()))
                    .andExpect(jsonPath("$[0].options[1].image").value(similarQuotationDtos.get(0).getOptions().get(1).getImage()))
                    .andExpect(jsonPath("$[0].options[1].price").value(similarQuotationDtos.get(0).getOptions().get(1).getPrice()));
        }

        @ParameterizedTest
        @DisplayName("유효하지 않은 id를 포함하는 경우 NotFound로 응답한다.")
        @ValueSource(classes = {
                NoSuchPackageException.class,
                NoSuchDriveTrainException.class,
                NoSuchPowertrainException.class,
                NoSuchBodyTypeException.class,
                NoSuchCarException.class,
                NoSuchTrimException.class,
                NoSuchOptionException.class,
                NoSuchPackageException.class
        })        void withInvalidRequest(Class<? extends RuntimeException> exceptionType) throws Exception {
            //given
            QuotationRequestDto requestDto = QuotationFixture.generateQuotationRequestDto();
            String jsonBody = objectMapper.writeValueAsString(requestDto);
            when(quotationService.findSimilarQuotations(requestDto)).thenThrow(exceptionType);

            //when
            mockMvc.perform(post("/quotation/similar")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(jsonBody))
                    //then
                    .andExpect(status().isNotFound());
        }
    }

    private static List<SimilarQuotationDto> generateSimilarQuotationDtoList() {
        ModelTypeNameDto modelTypeDto1 = ModelTypeNameDto.builder()
                .powertrainName("Powertrain 1")
                .bodytypeName("Bodytype 1")
                .drivetrainName("Drivetrain 1")
                .build();

        ModelTypeNameDto modelTypeDto2 = ModelTypeNameDto.builder()
                .powertrainName("Powertrain 2")
                .bodytypeName("Bodytype 2")
                .drivetrainName("Drivetrain 2")
                .build();

        OptionSummaryDto optionDto1 = OptionSummaryDto.builder()
                .id(101L)
                .name("Option 1")
                .category("Category 1")
                .image("option_image_1")
                .price(500)
                .build();

        OptionSummaryDto optionDto2 = OptionSummaryDto.builder()
                .id(102L)
                .name("Option 2")
                .category("Category 2")
                .image("option_image_2")
                .price(1000)
                .build();

        SimilarQuotationDto similarQuotationDto1 = SimilarQuotationDto.builder()
                .modelType(modelTypeDto1)
                .image("image_url_1")
                .price(10000)
                .options(List.of(optionDto1, optionDto2))
                .build();

        OptionSummaryDto optionDto3 = OptionSummaryDto.builder()
                .id(201L)
                .name("Option 3")
                .category("Category 1")
                .image("option_image_3")
                .price(700)
                .build();

        OptionSummaryDto optionDto4 = OptionSummaryDto.builder()
                .id(202L)
                .name("Option 4")
                .category("Category 2")
                .image("option_image_4")
                .price(1200)
                .build();

        SimilarQuotationDto similarQuotationDto2 = SimilarQuotationDto.builder()
                .modelType(modelTypeDto2)
                .image("image_url_2")
                .price(15000)
                .options(List.of(optionDto3, optionDto4))
                .build();

        return List.of(similarQuotationDto1, similarQuotationDto2);

    }

}
