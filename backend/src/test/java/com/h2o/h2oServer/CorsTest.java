package com.h2o.h2oServer;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@AutoConfigureMockMvc
@WebMvcTest(controllers = H2oServerApplication.class)
public class CorsTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    @Disabled
    @DisplayName("다른 호스트의 요청이 들어올 때 CORS 에러가 발생한다.")
    void corsOtherHost() throws Exception {
        mockMvc.perform(createPingRequest("https://example.com"))
                .andExpect(status().isForbidden());
    }

    @Test
    @Disabled
    @DisplayName("다른 프로토콜로 요청이 들어올 때 CORS 에러가 발생한다.")
    void corsOtherProtocol() throws Exception {
        mockMvc.perform(createPingRequest("http://h2-cartalog.site"))
                .andExpect(status().isForbidden());
    }

    @Test
    @Disabled
    @DisplayName("다른 포트로 요청이 들어올 때 CORS 에러가 발생한다.")
    void corsOtherPortNumber() throws Exception {
        mockMvc.perform(createPingRequest("https://h2-cartalog.site:3300"))
                .andExpect(status().isForbidden());
    }


    @ParameterizedTest
    @Disabled
    @DisplayName("지정한 origin으로 요청이 들어올 때는 CORS 에러가 발생하지 않는다.")
    @ValueSource(strings = {"https://h2-cartalog.site", "https://www.h2-cartalog.site"})
    void pass(String origin) throws Exception {
        mockMvc.perform(createPingRequest(origin))
                .andExpect(status().isOk());
    }

    private MockHttpServletRequestBuilder createPingRequest(String origin) {
        return get("/ping").header("Origin", origin);
    }
}
