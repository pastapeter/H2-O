package com.h2o.h2oServer.domain.options.api;

import com.h2o.h2oServer.domain.options.application.OptionsService;
import com.h2o.h2oServer.domain.options.dto.TrimOptionDto;
import com.h2o.h2oServer.domain.options.entity.enums.OptionType;
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
    public List<TrimOptionDto> getExtraOptions(@PathVariable Long trimId) {
        List<TrimOptionDto> trimPackages = optionsService.findTrimPackages(trimId);
        List<TrimOptionDto> trimExtraOptions = optionsService.findTrimOptions(trimId, OptionType.EXTRA);

        return Stream.concat(trimPackages.stream(), trimExtraOptions.stream())
                .collect(Collectors.toList());
    }
}
