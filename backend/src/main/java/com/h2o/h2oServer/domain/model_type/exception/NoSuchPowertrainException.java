package com.h2o.h2oServer.domain.model_type.exception;

public class NoSuchPowertrainException extends RuntimeException {
    public NoSuchPowertrainException() {
        super("존재하지 않는 파워트레인에 대한 요청입니다.");
    }

    public NoSuchPowertrainException(String message) {
        super(message);
    }
}
