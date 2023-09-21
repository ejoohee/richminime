package com.richminime.domain.gpt.service;

import com.richminime.domain.gpt.dao.PromptRepository;
import com.richminime.domain.gpt.domain.Prompt;
import com.richminime.domain.item.dto.ItemResDto;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.function.client.WebClient;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class PromptServiceImpl implements PromptService {

    private final PromptRepository promptRepository;
    @Value("${gpt.api-key")
    private String apikey;
    private String gptUrl = "https://api.openai.com/v1/chat/completions";
    @Override
    public String findChatbotReply(String ask) {
        WebClient webClient = WebClient.create();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization","Bearer " + apikey);
        //추후 시큐리티 완료 되면 getUser()로 대체
        List<Prompt> prompts = promptRepository.findByUser_UserId(1L);
        List<Map<String,String>> message = new ArrayList<>();
        Map<String,String> systemMessage = new HashMap<>();
        systemMessage.put("role","system");
        systemMessage.put("content","너는 은행 상담원이야");
        Map<String,String> userMessage;
        Map<String,String> assistantMessage;
        for(Prompt prompt : prompts){
            userMessage = new HashMap<>();
            userMessage.put("role","user");
            userMessage.put("content",prompt.getRoleUser());
            message.add(userMessage);
            assistantMessage = new HashMap<>();
            userMessage.put("role","assistant");
            userMessage.put("content",prompt.getRoleContent());
            message.add(assistantMessage);
        }
        Map<String, Object> requestBody = new HashMap<>();



        return "임시";
    }
}
