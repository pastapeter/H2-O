package com.h2o.h2oServer.global.exception.exceptionHandler;

import com.h2o.h2oServer.domain.car.exception.NoSuchCarException;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchBodyTypeException;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchDriveTrainException;
import com.h2o.h2oServer.domain.model_type.exception.NoSuchPowertrainException;
import com.h2o.h2oServer.domain.option.exception.NoSuchOptionException;
import com.h2o.h2oServer.domain.optionPackage.exception.NoSuchPackageException;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchExternalColorException;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchInternalColorException;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchTrimException;
import com.h2o.h2oServer.global.exception.ErrorResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import javax.servlet.http.HttpServletRequest;

@RestControllerAdvice
public class ControllerAdvice {

    private static final Logger logger = LoggerFactory.getLogger(ControllerAdvice.class);

    @ExceptionHandler({
            NoSuchPackageException.class,
            NoSuchDriveTrainException.class,
            NoSuchPowertrainException.class,
            NoSuchBodyTypeException.class,
            NoSuchCarException.class,
            NoSuchTrimException.class,
            NoSuchOptionException.class,
            NoSuchPackageException.class,
            NoSuchInternalColorException.class,
            NoSuchExternalColorException.class
    })
    public ResponseEntity<ErrorResponse> handleNotFoundExceptions(final RuntimeException e) {
        ErrorResponse errorResponse = ErrorResponse.of(e.getMessage());
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
    }

    @ExceptionHandler({Exception.class})
    public ResponseEntity<ErrorResponse> defaultHandler(final Exception e,
                                                        final HttpServletRequest request) {
        ErrorReport errorReport = new ErrorReport(request, e);
        logger.error(errorReport.log(), e);

        ErrorResponse errorResponse = ErrorResponse.of("예상하지 못한 서버 에러가 발생했습니다.");
        return ResponseEntity.internalServerError().body(errorResponse);
    }
}
