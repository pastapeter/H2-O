package com.h2o.h2oServer.domain.quotation.application;

import com.h2o.h2oServer.domain.option.entity.enums.HashTag;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.HashMap;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.offset;

@SpringBootTest
class CosineSimilarityCalculatorTest {

    @Autowired
    CosineSimilarityCalculator cosineSimilarityCalculator;

    @Test
    @DisplayName("해시태그 벡터의 코사인 유사도를 반환한다.")
    void testCalculateCosineSimilarity() {
        //given
        Map<HashTag, Integer> vector1 = new HashMap<>();
        vector1.put(HashTag.CAMPING, 3);
        vector1.put(HashTag.BEGINNER_DRIVING, 1);
        vector1.put(HashTag.CHILDREN, 2);

        Map<HashTag, Integer> vector2 = new HashMap<>();
        vector2.put(HashTag.CAMPING, 2);
        vector2.put(HashTag.BEGINNER_DRIVING, 2);
        vector2.put(HashTag.CHILDREN, 1);

        double expectedSimilarity = 0.8908708063747479;

        //when
        double similarity = cosineSimilarityCalculator.calculateCosineSimilarity(vector1, vector2);

        //then
        assertThat(similarity).isCloseTo(expectedSimilarity, offset(0.01));
    }

    @Test
    @DisplayName("해시태그 벡터의 코사인 유사도를 반환한다. - 1인 경우")
    void testCalculateCosineSimilarityWithOneValues() {
        //given
        Map<HashTag, Integer> vector1 = new HashMap<>();
        vector1.put(HashTag.CAMPING, 1);
        vector1.put(HashTag.BEGINNER_DRIVING, 1);
        vector1.put(HashTag.CHILDREN, 1);

        Map<HashTag, Integer> vector2 = new HashMap<>();
        vector2.put(HashTag.CAMPING, 1);
        vector2.put(HashTag.BEGINNER_DRIVING, 1);
        vector2.put(HashTag.CHILDREN, 1);

        double expectedSimilarity = 1.0;

        //when
        double similarity = cosineSimilarityCalculator.calculateCosineSimilarity(vector1, vector2);

        //then
        assertThat(similarity).isCloseTo(expectedSimilarity, offset(0.01));
    }
}
