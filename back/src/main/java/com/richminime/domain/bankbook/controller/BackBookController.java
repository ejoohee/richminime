package com.richminime.domain.bankbook.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/api/bankbook")
public class BackBookController {

    @GetMapping
    public String test1 (){

        return "성공";
    }
}
