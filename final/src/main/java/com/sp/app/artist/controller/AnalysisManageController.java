package com.sp.app.artist.controller;


import com.sp.app.artist.service.AnalysisManageService;
import com.sp.app.model.SessionInfo;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/artist/*")
public class AnalysisManageController {
    private final AnalysisManageService service;

    @GetMapping("salesStatus")
    public String handleSalesStatus(Model model,HttpSession session){
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("member");
        //map에 저장하고 그냥 map 넣은 값 가져와서 모델로 뿌려주는게 나을듯

            Map<String,Object> today = service.todayProduct(info.getMemberIdx());
            Map<String,Object> thisMonth = service.thisMonthProduct(info.getMemberIdx());
            Map<String,Object> previousMonth = service.previousMonthProduct(info.getMemberIdx());

            model.addAttribute("today",today);
            model.addAttribute("thisMonth",thisMonth);
            model.addAttribute("previousMonth",previousMonth);


        }catch (Exception e){
            log.info("handleSalesStatus : ",e);
        }
        return "artist/analysis/salesStatus";
    }


    @ResponseBody
    @GetMapping("charts")
    public Map<String, Object> handleCharts(HttpSession session) {

        Map<String, Object> model = new HashMap<String, Object>();
        try {
            Calendar cal = Calendar.getInstance();
            int y = cal.get(Calendar.YEAR);
            int m = cal.get(Calendar.MONTH) + 1;
            int d = cal.get(Calendar.DATE);

            Map<String,Object> map = new HashMap<String,Object>();

            SessionInfo info = (SessionInfo) session.getAttribute("member");


            String date = String.format("%04d-%02d-%02d", y, m, d);
            String month = String.format("%04d%02d", y, m);
            map.put("date",date);
            map.put("month",month);
            map.put("memberIdx",info.getMemberIdx());
            List<Map<String, Object>> days = service.dayTotalMoney(map);
            List<Map<String, Object>> months = service.monthTotalMoney(map);

            if(d < 20) {
                cal.add(Calendar.MONTH, -1);
                y = cal.get(Calendar.YEAR);
                m = cal.get(Calendar.MONTH) + 1;
                month = String.format("%04d%02d", y, m);
                map.put("month",month);
            }

            Map<String, Object> dayOfWeek = service.dayOfWeekTotalCount(map);
            dayOfWeek.put("month", month);

            model.put("days", days);
            model.put("months", months);
            model.put("dayOfWeek", dayOfWeek);

            model.put("state", "true");
        } catch (Exception e) {
            model.put("state", "false");
        }

        return model;
    }

}
