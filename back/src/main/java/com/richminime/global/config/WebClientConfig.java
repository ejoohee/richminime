package com.richminime.global.config;

import com.richminime.global.common.codef.CodefWebClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class WebClientConfig {

    @Bean
    public CodefWebClient codefWebClient(){
        return new CodefWebClient();
    }

}
