package com.h2o.h2oServer.domain.trim.Exception;

public class NoSuchInternalColorException extends RuntimeException {
    public NoSuchInternalColorException(String message) {
        super(message);
    }

    public NoSuchInternalColorException() {
        super("존재하지 않는 내장 색상입니다.");
    }
}
