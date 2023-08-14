package com.h2o.h2oServer.domain.option.api;

import com.h2o.h2oServer.domain.option.application.OptionService;
import com.h2o.h2oServer.domain.option.dto.OptionDetailsDto;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class OptionController {
    private final OptionService optionService;

    @GetMapping("/trim/{trimId}/option/{optionId}")
    public OptionDetailsDto getOptionInformation(@PathVariable Long trimId, @PathVariable Long optionId) {
        OptionDetailsDto optionInformation = optionService.findOptionInformation(optionId, trimId);
        return optionInformation;
    }
}
