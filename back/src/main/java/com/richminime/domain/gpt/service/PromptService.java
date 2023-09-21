package com.richminime.domain.gpt.service;

import com.richminime.domain.item.dto.ItemResDto;

import java.util.List;

public interface PromptService {
    String findChatbotReply(String prompt);

}
