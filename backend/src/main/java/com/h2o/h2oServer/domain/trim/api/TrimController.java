package com.h2o.h2oServer.domain.trim.api;

import com.h2o.h2oServer.domain.trim.application.TrimService;
import com.h2o.h2oServer.domain.trim.dto.ExternalColorDto;
import com.h2o.h2oServer.domain.trim.dto.InternalColorDto;
import com.h2o.h2oServer.domain.trim.dto.TrimDto;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class TrimController {

    private final TrimService trimService;

    @GetMapping("vehicle/{vehicleId}/trim")
    public List<TrimDto> getTrimInformation(@PathVariable Long vehicleId) {
        return trimService.findTrimInformation(vehicleId);
    }

    @GetMapping("trim/{trimId}/external-color")
    public List<ExternalColorDto> getExternalColorInformation(@PathVariable Long trimId) {
        return trimService.findExternalColorInformation(trimId);
    }

    @GetMapping("/trim/{trimId}/internal-color")
    public List<InternalColorDto> getInternalColorInformation(@PathVariable Long trimId) {
        return trimService.findInternalColorInformation(trimId);
    }
}
