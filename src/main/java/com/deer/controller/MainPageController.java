package com.deer.controller;

import com.deer.domain.User;
import com.deer.service.CardService;
import com.deer.service.TradeService;
import com.deer.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "/mainPage")
public class MainPageController {

    private final int rootID=5;
    private final int pageMax = 5;

    @Resource
    private UserService userService;

    @Resource
    private TradeService tradeService;

    @Resource
    private CardService cardService;

    /**
     * 返回首页需要的信息
     * @param session 用户在本地的仓库
     * @return 首页信息
     */
    @RequestMapping(value = "/queryInfo.do")
    public ModelAndView queryInfo(HttpSession session){
        ModelAndView mv = new ModelAndView();
        int ID = (int) session.getAttribute("ID");
        // 余额
        mv.addObject("charge",userService.queryOneUserCharge(ID));
        // 订单数量
        if (rootID==ID){
            mv.addObject("tradeAmount",tradeService.queryCountTrade(null));
        }else{
            mv.addObject("tradeAmount",tradeService.queryCountTrade(ID));
        }
        // 已受理
        mv.addObject("processTradeAmount", tradeService.queryCountProcessTradeByUser_ID(ID));
        // 移动卡片数量
        mv.addObject("mobileCardAmount",cardService.queryCountCardByServer(0,ID));
        // 电信
        mv.addObject("telecomCardAmount",cardService.queryCountCardByServer(1,ID));
        // 联通
        mv.addObject("unicomCardAmount",cardService.queryCountCardByServer(2,ID));
        mv.setViewName("/mainPage/firstpage.jsp");
        return mv;
    }

    /**
     * 获取用户账号
     * @param session 用户在本地的仓库
     * @return 用户账号 userName
     */
    @RequestMapping(value = "/topDisplay.do")
    public ModelAndView queryOneUserAllInfoByID(HttpSession session){
        ModelAndView mv = new ModelAndView();
        Integer ID = (Integer) session.getAttribute("ID");
        User user = userService.queryOneUserByID(ID);
        mv.addObject("userName", user.getName());
        mv.setViewName("/mainPage/top.jsp");
        return mv;
    }

    /**
     * 获取网页左边内容
     * @param session 用户在本地的仓库
     * @return 网页左边的内容
     *         priority 用户权限
     */
    @RequestMapping(value = "/leftDisplay.do")
    public ModelAndView leftDisplay(HttpSession session){
        ModelAndView mv = new ModelAndView();
        int priority = (int) session.getAttribute("priority");
        mv.addObject("priority", priority);
        mv.setViewName("/mainPage/left.jsp");
        return mv;
    }

}
