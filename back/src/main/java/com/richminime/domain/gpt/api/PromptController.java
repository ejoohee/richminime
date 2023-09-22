package com.richminime.domain.gpt.api;

import com.richminime.domain.gpt.service.PromptService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class PromptController {

    private final PromptService promptService;


}
