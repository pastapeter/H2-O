package com.h2o.h2oServer.domain.trim.Exception;

public class NoSuchTrimException extends RuntimeException {
    public NoSuchTrimException(String message) {
        super(message);
    }

    public NoSuchTrimException() {
        super("존재하지 않는 트림에 대한 요청입니다.");
    }
}
