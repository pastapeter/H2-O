package com.h2o.h2oServer.domain.model_type.exception;

public class NoSuchDriveTrainException extends RuntimeException {
    public NoSuchDriveTrainException() {
        super("존재하지 않는 구동 방식에 대한 요청입니다.");
    }

    public NoSuchDriveTrainException(String message) {
        super(message);
    }
}
