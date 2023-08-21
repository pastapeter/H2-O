package com.h2o.h2oServer.global.util;

import com.h2o.h2oServer.domain.car.exception.NoSuchCarException;
import com.h2o.h2oServer.domain.option.exception.NoSuchOptionException;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchExternalColorException;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchInternalColorException;
import com.h2o.h2oServer.domain.trim.Exception.NoSuchTrimException;

import java.util.List;

public class Validator {
    public static <E> void validateExistenceOfCarId(List<E> entities) {
        if (entities == null || entities.isEmpty()) {
            throw new NoSuchCarException();
        }
    }

    public static <E> void validateExistenceOfOptions(List<E> entities) {
        if (entities == null || entities.isEmpty()) {
            throw new NoSuchOptionException();
        }
    }

    public static <E> void validateExistenceOfTrim(List<E> entities) {
        if (entities == null || entities.isEmpty()) {
            throw new NoSuchTrimException();
        }
    }

    public static <E> void validateExistenceOfExternalColor(List<E> entities) {
        if (entities == null || entities.isEmpty()) {
            throw new NoSuchExternalColorException();
        }
    }

    public static <E> void validateExistenceOfInternalColor(List<E> entities) {
        if (entities == null || entities.isEmpty()) {
            throw new NoSuchInternalColorException();
        }
    }
}
