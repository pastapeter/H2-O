package com.h2o.h2oServer.domain.options.api;

import com.h2o.h2oServer.domain.options.application.OptionsService;
import com.h2o.h2oServer.domain.options.dto.TrimDefaultOptionDto;
import com.h2o.h2oServer.domain.options.dto.TrimExtraOptionDto;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@RestController
@RequiredArgsConstructor
public class OptionsController {

    private final OptionsService optionsService;

    @GetMapping("/trim/{trimId}/extra-option")
    public List<TrimExtraOptionDto> getExtraOptions(@PathVariable Long trimId) {
        List<TrimExtraOptionDto> trimPackages = optionsService.findTrimPackages(trimId);
        List<TrimExtraOptionDto> trimExtraOptions = optionsService.findTrimExtraOptions(trimId);

        return Stream.concat(trimPackages.stream(), trimExtraOptions.stream())
                .collect(Collectors.toList());
    }

    @GetMapping("/trim/{trimId}/default-option")
    public List<TrimDefaultOptionDto> getDefaultOptions(@PathVariable Long trimId) {
        return optionsService.findTrimDefaultOptions(trimId);
    }
}
