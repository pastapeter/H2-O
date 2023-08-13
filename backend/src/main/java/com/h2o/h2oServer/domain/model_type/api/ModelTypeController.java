package com.h2o.h2oServer.domain.model_type.api;

import com.h2o.h2oServer.domain.model_type.application.ModelTypeService;
import com.h2o.h2oServer.domain.model_type.dto.ModelTypeDto;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
public class ModelTypeController {

    private final ModelTypeService modelTypeService;

    @GetMapping("/car/{carId}/model-type")
    public ModelTypeDto modelType(@PathVariable Long carId) {
        return modelTypeService.findModelTypes(carId);
    }
}
