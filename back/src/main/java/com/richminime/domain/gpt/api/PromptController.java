package com.richminime.domain.gpt.api;

import com.richminime.domain.gpt.dto.PromptReqDto;
import com.richminime.domain.gpt.dto.PromptResDto;
import com.richminime.domain.gpt.service.PromptService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@RestController
@RequiredArgsConstructor
@RequestMapping("/prompt")
public class PromptController {

    private final PromptService promptService;

    @PostMapping
    public Mono<PromptResDto> findChatbotReply(@RequestBody PromptReqDto dto){
        return promptService.findChatbotReply(dto);
    }
}
