package com.deer.controller;

import com.deer.domain.Trade;
import com.deer.service.CardService;
import com.deer.service.TradeService;
import com.deer.vo.QueryTradeCondition;
import com.deer.vo.TradeDisplayInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/trade")
public class TradeController {

    private final int pageMax = 5;

    @Resource
    TradeService tradeService;

    @Resource
    CardService cardService;

    /**
     * 通过用户和类型获取显示订单
     * @param session 用户在服务器的仓库
     * @param type 订单类型
     * @return 订单
     */
    @RequestMapping(value = "/queryEasyRenewalTrade.do")
    public ModelAndView queryEasyRenewalTrade(int type, int page, HttpSession session){
        ModelAndView mv = new ModelAndView();
        int ID = (int) session.getAttribute("ID");
        Map<String,Object> map = tradeService.queryTradeDisplayInfoByUser_IDAndType(ID,type,page);
        List<TradeDisplayInfo> tradeDisplayInfoList = (List<TradeDisplayInfo>) map.get("tradeDisplayInfoList");
        for (TradeDisplayInfo tradeDisplayInfo:tradeDisplayInfoList){
            tradeDisplayInfo.setCharge_time(tradeDisplayInfo.getCharge_time().substring(0, 19));
            if (tradeDisplayInfo.getProcessing_time()!=null) {
                tradeDisplayInfo.setProcessing_time(tradeDisplayInfo.getProcessing_time().substring(0, 19));
            }
        }
        mv.addObject("maxPage", map.get("maxPage"));
        mv.addObject("page", page);
        mv.addObject("pageMax", pageMax);
        mv.addObject("action", "trade/queryEasyRenewalTrade.do");
        mv.addObject("tradeDisplayInfoList",tradeDisplayInfoList);
        if (type == 0){
            mv.setViewName("/orderManagement/purchaseOrder.jsp");
        }else if (type == 1){
            mv.setViewName("/orderManagement/renewalOrder.jsp");
        }
        return mv;
    }

    /**
     * 通过查询条件获得订单
     * @param queryTradeCondition 查询条件的实体类
     * @return 查询出的订单
     */
    @RequestMapping(value = "/queryTradeInfoByCondition.do")
    public ModelAndView queryTradeInfoByCondition(QueryTradeCondition queryTradeCondition, int page, HttpSession session){
        ModelAndView mv = new ModelAndView();
        int ID = (int) session.getAttribute("ID");
        if (queryTradeCondition.getStartCharge_time().equals("2020-01-01")){
            queryTradeCondition.setStartCharge_time("");
        }
        if (queryTradeCondition.getEndCharge_time().equals("2020-01-01")){
            queryTradeCondition.setEndCharge_time("");
        }
        Map<String,Object> map = tradeService.queryTradeInfoByCondition(ID, queryTradeCondition, page);
        List<TradeDisplayInfo> tradeDisplayInfoList = (List<TradeDisplayInfo>) map.get("tradeDisplayInfoList");
        if (tradeDisplayInfoList.size()==0){
            page = 1;
            map = tradeService.queryTradeInfoByCondition(ID, queryTradeCondition, page);
            tradeDisplayInfoList = (List<TradeDisplayInfo>) map.get("tradeDisplayInfoList");
        }
        for (TradeDisplayInfo tradeDisplayInfo:tradeDisplayInfoList) {
            tradeDisplayInfo.setCharge_time(tradeDisplayInfo.getCharge_time().substring(0, 19));
            if (tradeDisplayInfo.getProcessing_time() != null) {
                tradeDisplayInfo.setProcessing_time(tradeDisplayInfo.getProcessing_time().substring(0, 19));
            }
        }
        if (queryTradeCondition.getStartCharge_time().equals("")){
            queryTradeCondition.setStartCharge_time("2020-01-01");
        }
        if (queryTradeCondition.getEndCharge_time().equals("")){
            queryTradeCondition.setEndCharge_time("2020-01-01");
        }
        mv.addObject("maxPage", map.get("maxPage"));
        mv.addObject("page", page);
        mv.addObject("pageMax", pageMax);
        mv.addObject("action", "trade/queryTradeInfoByCondition.do");
        mv.addObject("tradeDisplayInfoList",tradeDisplayInfoList);
        mv.addObject("queryTradeCondition",queryTradeCondition);
        if (queryTradeCondition.getType() == 0){
            mv.setViewName("/orderManagement/purchaseOrderSearch.jsp");
        }else if (queryTradeCondition.getType() == 1){
            mv.setViewName("/orderManagement/renewalOrderSearch.jsp");
        }
        return mv;
    }

    /**
     * 通过用户获取未受理订单编号
     * @param session 用户在服务器的仓库
     * @param type 订单类型
     * @param user_ID 用户ID
     * @return 订单
     */
    @RequestMapping(value = "/queryUnProfessTradeByUser.do")
    @ResponseBody
    public Map<String,Object> queryUnProfessTradeByUser(int type, int user_ID, String ICCID, HttpSession session){
        Map<String,Object> map = new HashMap<>();
        int ID = (int) session.getAttribute("ID");
        int server = cardService.queryServerByICCID(ICCID);
        List<Integer> IDList = tradeService.queryUnProfessTradeByUserAndServer(user_ID,type,server);
        map.put("IDList",IDList);
        return map;
    }

}
