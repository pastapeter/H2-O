package com.h2o.h2oServer.domain.quotation.application;

import com.h2o.h2oServer.domain.option.entity.enums.HashTag;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

public class CosineSimilarityCalculator {

    private static final List<HashTag> hashTagIndex = List.of(HashTag.values());

    public static double calculateCosineSimilarity(Map<HashTag, Integer> map1, Map<HashTag, Integer> map2) {
        return calculateCosineSimilarity(toVector(map1), toVector(map2));
    }

    public static double calculateCosineSimilarity(int[] vector1, int[] vector2) {
        if (vector1.length != vector2.length) {
            throw new IllegalArgumentException("두 벡터의 길이가 다릅니다.");
        }

        double dotProduct = 0.0;
        double norm1 = 0.0;
        double norm2 = 0.0;

        for (int i = 0; i < vector1.length; i++) {
            dotProduct += vector1[i] * vector2[i];
            norm1 += Math.pow(vector1[i], 2);
            norm2 += Math.pow(vector2[i], 2);
        }

        if (norm1 == 0.0 || norm2 == 0.0) {
            return 0.0;
        }

        return dotProduct / (Math.sqrt(norm1) * Math.sqrt(norm2));
    }

    private static int[] toVector(Map<HashTag, Integer> map) {
        int[] vector = new int[hashTagIndex.size()];


        for (HashTag hashTag : map.keySet()) {
            vector[hashTagIndex.indexOf(hashTag)] = map.get(hashTag);
        }

        return vector;
    }
}
