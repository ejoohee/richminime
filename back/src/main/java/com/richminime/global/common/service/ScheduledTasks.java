package com.richminime.global.common.service;

import org.springframework.scheduling.annotation.Scheduled;

public class ScheduledTasks {


    @Scheduled(cron = "0 0 6 * * ?") //매일 오전 6시에 실행
    public void transferRedisToDb(){

    }

}
