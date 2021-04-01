package com.deer.controller;

import com.deer.domain.AccountTradeError;
import com.deer.service.AccountTradeErrorService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/accountTradeError")
public class AccountTradeErrorController {

    private final int rootID=5;
    private final int pageMax = 5;

    @Resource
    AccountTradeErrorService accountTradeErrorService;

    /**
     * 获取错误信息
     * @param session 用户在本地的仓库
     * @return 错误信息
     */
    @RequestMapping(value = "/showErrorInfo.do")
    public ModelAndView showErrorInfo(int page, HttpSession session){
        int ID = (int) session.getAttribute("ID");
        ModelAndView mv = new ModelAndView();
        int priority = (int) session.getAttribute("priority");
        if (priority==1){
            mv.addObject("msg","该用户没有权限");
            mv.setViewName("/result.jsp");
            return mv;
        }
        Map<String,Object> map = accountTradeErrorService.queryAllDisplayInfo(page);
        mv.addObject("accountTradeErrorList",map.get("accountTradeErrorList"));
        mv.addObject("maxPage", map.get("maxPage"));
        mv.addObject("page", page);
        mv.addObject("action", "accountTradeError/showErrorInfo.do");
        mv.addObject("pageMax", pageMax);
        mv.setViewName("/logManagement/errorLog.jsp");
        return mv;
    }

    /**
     * 1分钟触发一次，解决Error中的问题
     */
    @Scheduled(cron = "0 */1 * * * ?")
    @Transactional
    public void dealError(){
        accountTradeErrorService.dealError();
    }
}
