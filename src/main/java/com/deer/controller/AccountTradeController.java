package com.deer.controller;

import com.deer.domain.AccountTrade;
import com.deer.service.AccountTradeErrorService;
import com.deer.service.AccountTradeService;
import com.deer.service.UserService;
import com.deer.vo.QueryAccountTradeCondition;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping(value = "/accountTrade")
@Controller
public class AccountTradeController {

    private final int rootID=5;
    private final int pageMax = 5;

    @Resource
    AccountTradeService accountTradeService;

    @Resource
    UserService userService;

    @Resource
    AccountTradeErrorService accountTradeErrorService;

    /**
     * 账户充值前
     * @param session 用户在本地的仓库
     * @return 账户余额和充值页面
     */
    @RequestMapping(value = "/accountRechargeOne.do")
    public ModelAndView accountRechargeOne(HttpSession session){
        ModelAndView mv = new ModelAndView();
        int user_ID = (int) session.getAttribute("ID");
        mv.addObject("charge",userService.queryOneUserCharge(user_ID));
        mv.setViewName("/businessManagement/accountRechargeone.jsp");
        return mv;
    }

    /**
     * 充值账单订单记录
     * @param accountTrade 账单信息
     * @param session 用户在本地的仓库
     * @return 记录结果
     */
    @RequestMapping(value = "/accountRechargeTwo.do")
    public ModelAndView accountRechargeTwo(AccountTrade accountTrade, HttpSession session){
        ModelAndView mv = new ModelAndView();
        int ID = (int) session.getAttribute("ID");
        accountTrade.setUser_ID(ID);
        int num = accountTradeService.accountRechargeTradeRecord(accountTrade);
        if (num != -1){
            mv.addObject("ID", num);
            mv.addObject("charge",accountTrade.getCharge_trade());
            mv.addObject("charge_server",accountTrade.getCharge_server());
            mv.addObject("chargeReal", accountTrade.getCharge_trade()+accountTrade.getCharge_server());
            mv.setViewName("/businessManagement/accountRechargetwo.jsp");
        }else{
            mv.addObject("msg", "提交充值信息失败，请稍后再试！");
            mv.setViewName("/result.jsp");
        }
        return mv;
    }

    /**
     * 账户充值
     * @return 执行结果
     */
    @RequestMapping(value = "/accountRechargeThree.do")
    @ResponseBody
    public Map<String,Object> accountRechargeThree(HttpSession session, float charge, int ID){
        Map<String,Object> map = new HashMap<>();
        int user_ID = (int) session.getAttribute("ID");
        int num = 0;
        /**
         * 提供二维码，提供支付接口，交钱给本公司，根据结果判断是否修改数据库
         * 支付金额为charge_server+charge_trade
         */
        boolean payResult = true;
        if (payResult){
/*            if (accountTradeService.queryTradeStatusByID(ID)==0){
                map.put("tag", 1);
                map.put("msg", "订单已提交" );
                return map;
            }*/
            num = accountTradeService.accountRecharge(user_ID, charge, ID);
            if (num == 2){
                map.put("tag", 0);
                map.put("msg", "充值成功");
            }else if (num == 3){
                map.put("tag", 1);
                map.put("msg", "充值后的账户余额达到上限，充值失败！上限为9999,999");
            }else{
                map.put("tag", 0);
                map.put("msg", "数据更新失败，请稍等，5-10分钟之内到账");
                num = 0;
                while (num++!=5) {
                    int a = accountTradeErrorService.insertErrorLog(ID);
                    if (a==1) break;
                }
            }
        }else{
            map.put("msg","支付失败，请重新支付");
        }
        return map;
    }

    /**
     * 处理未支付订单
     * @param session 用户在本地的仓库
     * @param ID 订单ID
     * @return 用户支付页面
     */
    @RequestMapping(value = "/processPendingOrder.do")
    public ModelAndView processPendingOrder(HttpSession session, int ID){
        ModelAndView mv = new ModelAndView();
        int user_ID = (int) session.getAttribute("ID");
        AccountTrade accountTrade = accountTradeService.queryTradeByID(ID);
        mv.addObject("ID", ID);
        mv.addObject("charge",accountTrade.getCharge_trade());
        mv.addObject("charge_server",accountTrade.getCharge_server());
        mv.addObject("chargeReal", accountTrade.getCharge_trade()+accountTrade.getCharge_server());
        mv.setViewName("/businessManagement/accountRechargetwo.jsp");
        return mv;
    }

    /**
     * 根据用户和类型查询账户订单信息
     * @param type 订单类型
     * @param session 用户在本地的仓库
     * @return 返回网页
     */
    @RequestMapping(value = "/queryAccountTradeAllInfo.do")
    public ModelAndView queryAccountTradeAllInfo(int type, int page, HttpSession session){
        ModelAndView mv = new ModelAndView();
        int user_ID = (int) session.getAttribute("ID");
        Map<String,Object> map = new HashMap<>();
        if (user_ID == rootID){
            map = accountTradeService.queryAccountTradeAllInfo(null, type, page);
        }else{
            map = accountTradeService.queryAccountTradeAllInfo(user_ID, type, page);
        }
        List<AccountTrade> accountTradeList = (List<AccountTrade>) map.get("accountTradeList");
        for (AccountTrade accountTrade:accountTradeList){
            accountTrade.setCharge_time(accountTrade.getCharge_time().substring(0, 19));
            if (accountTrade.getProcessing_time()!=null) {
                accountTrade.setProcessing_time(accountTrade.getProcessing_time().substring(0, 19));
            }
        }
        int maxPage = (int) map.get("num");
        mv.addObject("accountTradeList",accountTradeList);
        mv.addObject("maxPage", maxPage);
        mv.addObject("page", page);
        mv.addObject("pageMax", pageMax);
        mv.addObject("action", "accountTrade/queryAccountTradeAllInfo.do");
        if (type == 0){
            mv.setViewName("/orderManagement/accountOrder.jsp");
        }else if (type == 1){
            mv.setViewName("提现管理的网址");
        }
        return mv;
    }

    /**
     * 通过查询条件获得订单
     * @param queryAccountTradeCondition 查询条件的实体类
     * @return 查询出的订单
     */
    @RequestMapping(value = "/queryAccountTradeInfoByCondition.do")
    public ModelAndView queryTradeInfoByCondition(QueryAccountTradeCondition queryAccountTradeCondition, int page, HttpSession session){
        ModelAndView mv = new ModelAndView();
        int ID = (int) session.getAttribute("ID");
        if (ID==rootID){
                queryAccountTradeCondition.setUser_ID(-1);
        }else{
            queryAccountTradeCondition.setUser_ID(ID);
        }
        if (queryAccountTradeCondition.getStartCharge_time().equals("2020-01-01")){
            queryAccountTradeCondition.setStartCharge_time("");
        }
        if (queryAccountTradeCondition.getEndCharge_time().equals("2020-01-01")){
            queryAccountTradeCondition.setEndCharge_time("");
        }
        Map<String,Object> map = new HashMap<>();
        map = accountTradeService.queryAccountTradeInfoByCondition(queryAccountTradeCondition,page);
        List<AccountTrade> accountTradeList = (List<AccountTrade>) map.get("accountTradeList");
        if (accountTradeList.size() == 0){
            page = 1;
            map = accountTradeService.queryAccountTradeInfoByCondition(queryAccountTradeCondition,page);
            accountTradeList = (List<AccountTrade>) map.get("accountTradeList");
        }
        for (AccountTrade accountTrade:accountTradeList) {
            accountTrade.setCharge_time(accountTrade.getCharge_time().substring(0, 19));
            if (accountTrade.getProcessing_time() != null) {
                accountTrade.setProcessing_time(accountTrade.getProcessing_time().substring(0, 19));
            }
        }
        int maxPage = (int) map.get("num");
        mv.addObject("accountTradeList",accountTradeList);
        mv.addObject("maxPage", maxPage);
        mv.addObject("page", page);
        mv.addObject("pageMax", pageMax);
        mv.addObject("action", "accountTrade/queryAccountTradeInfoByCondition.do");
        if (queryAccountTradeCondition.getStartCharge_time().equals("")){
            queryAccountTradeCondition.setStartCharge_time("2020-01-01");
        }
        if (queryAccountTradeCondition.getEndCharge_time().equals("")){
            queryAccountTradeCondition.setEndCharge_time("2020-01-01");
        }
        mv.addObject("queryAccountTradeCondition", queryAccountTradeCondition);
        if (queryAccountTradeCondition.getType() == 0){
            mv.setViewName("/orderManagement/accountOrderSearch.jsp");
        }else if (queryAccountTradeCondition.getType() == 1){
            mv.setViewName("提现管理的网址");
        }
        return mv;
    }
}
