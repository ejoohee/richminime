package com.richminime.domain.gpt.service;

import com.richminime.domain.gpt.dto.PromptReqDto;
import com.richminime.domain.gpt.dto.PromptResDto;
import com.richminime.domain.item.dto.ItemResDto;
import reactor.core.publisher.Mono;

import java.util.List;

public interface PromptService {
    Mono<PromptResDto> findChatbotReply(PromptReqDto dto);

}
