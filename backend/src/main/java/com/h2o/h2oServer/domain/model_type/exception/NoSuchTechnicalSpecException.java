package com.h2o.h2oServer.domain.model_type.exception;

public class NoSuchTechnicalSpecException extends RuntimeException {
    public NoSuchTechnicalSpecException() {
        super("존재하지 않는 차량 성능 정보에 대한 요청입니다.");
    }

    public NoSuchTechnicalSpecException(String message) {
        super(message);
    }
}
