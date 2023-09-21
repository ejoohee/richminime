package com.richminime.domain.gpt.api;

import com.richminime.domain.gpt.service.PromptService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;

@RestController
@RequiredArgsConstructor
@RequestMapping("/prompt")
public class PromptController {

    private final PromptService promptService;

    @PostMapping
    public Mono<String> findChatbotReply(String request){
        return promptService.findChatbotReply(request);
    }

}
