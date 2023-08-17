package com.h2o.h2oServer.domain.model_type.exception;

public class NoSuchBodyTypeException extends RuntimeException {
    public NoSuchBodyTypeException() {
        super("존재하지 않는 바디타입에 대한 요청입니다.");
    }

    public NoSuchBodyTypeException(String message) {
        super(message);
    }
}
