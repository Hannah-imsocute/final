package com.sp.app.artist.controller;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/artist/*")
public class AnalysisManageController {

    @GetMapping("salesStatus")
    public String handleSalesStatus(Model model){
        try {

        }catch (Exception e){

        }
        return "artist/analysis/salesStatus";
    }

}
