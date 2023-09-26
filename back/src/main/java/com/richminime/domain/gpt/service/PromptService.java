package com.richminime.domain.gpt.service;

import com.richminime.domain.item.dto.ItemResDto;
import reactor.core.publisher.Mono;

import java.util.List;

public interface PromptService {
    Mono<String> findChatbotReply(String prompt);

}
