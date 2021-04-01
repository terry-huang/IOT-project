package com.deer.controller;

import com.deer.domain.Card;
import com.deer.domain.User;
import com.deer.service.CardService;
import com.deer.service.Set_CardService;
import com.deer.service.UserService;
import com.deer.vo.CardDisplayInfo;
import com.deer.vo.QueryCardCondition;
import com.deer.vo.Set_CardDisplayInfo;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping(value = "/card")
public class CardController {

    private final int rootID = 5;
    private final int pageMax = 5;

    @Resource
    private CardService cardService;

    @Resource
    private UserService userService;

    @Resource
    private Set_CardService set_cardService;

    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date addTime;

    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date addTime1;

    /**
     * 通过运营商返回卡片
     * @param server 套餐名
     * @return 返回卡片数组
     */
    @RequestMapping(value = "/queryAllCardInfo.do", produces = "text/plain;charset=utf-8")
    public ModelAndView queryServerToCardInfo(int server, int page, String[] ICCID, int presentPage, HttpSession session){
        ModelAndView mv = new ModelAndView();
        Map<String,Object> map = new HashMap<>();
        int ID = (int) session.getAttribute("ID");
        int priority = (int) session.getAttribute("priority");
        if (priority==1){
            map = cardService.queryAllDisplayInfoByServer(server,ID,page);
        }else {
            map = cardService.queryAllDisplayInfoByServer(server,null,page);
        }
        List<CardDisplayInfo> cardDisplayInfoList = (List<CardDisplayInfo>) map.get("cardDisplayInfoList");
        int maxPage = (int) map.get("num");
        mv.addObject("cardDisplayInfoList",cardDisplayInfoList);
        mv.addObject("maxPage", maxPage);
        mv.addObject("page", page);
        mv.addObject("pageMax", pageMax);
        mv.addObject("action", "card/queryAllCardInfo.do");
        mv.addObject("recordedCardAmount", 0);
        // 分界线 下面是分页卡片选择部分
        List<String> ICCIDList = new ArrayList<>();
        TreeSet<String> set = new TreeSet<>();
        if (session.getAttribute("ICCID") != null) {
            set = (TreeSet<String>) session.getAttribute("ICCID");
            if (set.size()!=0) {
                if (server != cardService.queryServerByICCID(set.first()) && ICCID != null) {
                    set = new TreeSet<String>(Arrays.asList(ICCID));
                    session.setAttribute("ICCID", set);
                }
            }
        }
        if (priority == 1) {
            ICCIDList = cardService.queryICCIDByServerAndPage(server, ID, presentPage);
        } else {
            ICCIDList = cardService.queryICCIDByServerAndPage(server, null, presentPage);
        }
        List<String> ICCIDList1 = new ArrayList<>();
        if (ICCID != null) {
            ICCIDList1 = Arrays.asList(ICCID);
            set.addAll(ICCIDList1);
            for (String iccid : ICCIDList) {
                if (!ICCIDList1.contains(iccid)) {
                    if (set.contains(iccid)) {
                        set.remove(iccid);
                    }
                }
            }
        } else {
            if (presentPage!=0) {
                for (String iccid : ICCIDList) {
                    if (set.contains(iccid)) {
                        set.remove(iccid);
                    }
                }
            }
        }
        int recordedCardAmount = 0;
        if (set.size() != 0) {
            recordedCardAmount = set.size();
            for (CardDisplayInfo cardDisplayInfo:cardDisplayInfoList){
                for (String s:set){
                    if (s.equals(cardDisplayInfo.getICCID())){
                        recordedCardAmount--;
                    }
                }
            }
            if (server != cardService.queryServerByICCID(set.first())) {
                recordedCardAmount = 0;
            }
        }
        mv.addObject("recordedCard", set);
        mv.addObject("recordedCardAmount", recordedCardAmount);
        session.setAttribute("ICCID", set);
        if (server == 0){
            mv.setViewName("/dataManagement/mobileCard.jsp");
        }else if (server == 1){
            mv.setViewName("/dataManagement/telecomCard.jsp");
        }else if (server == 2){
            mv.setViewName("/dataManagement/unicomCard.jsp");
        }
        return mv;
    }

    /**
     * 通过查询条件返回卡片（包括高级查询）
     * @param queryCardCondition 查询条件
     * @return 卡片数组
     */
    @RequestMapping(value = "/queryCardInfoByCondition.do", produces = "text/plain;charset=utf-8")
    public ModelAndView queryCardInfoByCondition(QueryCardCondition queryCardCondition, @RequestParam(value = "ICCID", required = false, defaultValue = "") String[] ICCID, int page, int presentPage, HttpSession session){
        ModelAndView mv = new ModelAndView();
        int ID = (int) session.getAttribute("ID");
        int priority = (int) session.getAttribute("priority");
        Map<String,Object> map = new HashMap<>();
        String input1 = "";
        if ("2020-01-01".equals(queryCardCondition.getInput1())){
            input1 = "2020-01-01";
            queryCardCondition.setInput1("");
        }
        if (priority==1){
            queryCardCondition.setUserID(ID);
            map = cardService.queryAllDisplayInfoByCondition(queryCardCondition, page);
        }else {
            map = cardService.queryAllDisplayInfoByCondition(queryCardCondition, page);
        }
        List<CardDisplayInfo> cardDisplayInfoList = (List<CardDisplayInfo>) map.get("cardDisplayInfoList");
        int maxPage = (int) map.get("num");
        if (cardDisplayInfoList.size() == 0){
            page = 1;
            if (priority==1){
                map = cardService.queryAllDisplayInfoByCondition(queryCardCondition, page);
            }else {
                map = cardService.queryAllDisplayInfoByCondition(queryCardCondition, page);
            }
            cardDisplayInfoList = (List<CardDisplayInfo>) map.get("cardDisplayInfoList");
        }
        if ("".equals(queryCardCondition.getInput1())){
            queryCardCondition.setInput1("2020-01-01");
        }
        mv.addObject("cardDisplayInfoList",cardDisplayInfoList);
        mv.addObject("page", page);
        mv.addObject("maxPage", maxPage);
        mv.addObject("pageMax", pageMax);
        mv.addObject("action", "card/queryCardInfoByCondition.do");
        mv.addObject("priority", priority);
        mv.addObject("queryCardCondition", queryCardCondition);
        List<String> ICCIDList = new ArrayList<>();
        TreeSet<String> set = new TreeSet<>();
        if (session.getAttribute("ICCID") != null) {
            set = (TreeSet<String>) session.getAttribute("ICCID");
            if (set.size()!=0) {
                if (queryCardCondition.getServer() != cardService.queryServerByICCID(set.first()) && ICCID != null) {
                    set = new TreeSet<String>(Arrays.asList(ICCID));
                    session.setAttribute("ICCID", set);
                }
            }
        }
        if (priority == 1) {
            ICCIDList = cardService.queryICCIDByServerAndPage(queryCardCondition.getServer(), ID, presentPage);
        } else {
            ICCIDList = cardService.queryICCIDByServerAndPage(queryCardCondition.getServer(), null, presentPage);
        }
        List<String> ICCIDList1 = new ArrayList<>();
        if (ICCID != null) {
            ICCIDList1 = Arrays.asList(ICCID);
            set.addAll(ICCIDList1);
            for (String iccid : ICCIDList) {
                if (!ICCIDList1.contains(iccid)) {
                    if (set.contains(iccid)) {
                        set.remove(iccid);
                    }
                }
            }
        } else {
            if (presentPage!=0) {
                for (String iccid : ICCIDList) {
                    if (set.contains(iccid)) {
                        set.remove(iccid);
                    }
                }
            }
        }
        int recordedCardAmount = 0;
        if (set.size() != 0) {
            recordedCardAmount = set.size();
            for (CardDisplayInfo cardDisplayInfo:cardDisplayInfoList){
                for (String s:set){
                    if (s.equals(cardDisplayInfo.getICCID())){
                        recordedCardAmount--;
                    }
                }
            }
            if (queryCardCondition.getServer() != cardService.queryServerByICCID(set.first())) {
                recordedCardAmount = 0;
            }
        }
        mv.addObject("recordedCard", set);
        mv.addObject("recordedCardAmount", recordedCardAmount);
        session.setAttribute("ICCID", set);
        if (queryCardCondition.getServer()==0){
            mv.setViewName("/dataManagement/mobileCardSearch.jsp");
        } else if (queryCardCondition.getServer()==1){
            mv.setViewName("/dataManagement/telecomCardSearch.jsp");
        } else if (queryCardCondition.getServer()==2){
            mv.setViewName("/dataManagement/unicomCardSearch.jsp");
        }
        return mv;
    }

    /**
     * 划拨卡片筛选卡片
     * 1.选择卡片并筛选卡片是否为公司所有并筛选出欠费卡片
     * 2.划拨卡片的对象
     * @param ICCID 选中卡片的ICCID
     * @return ICCIDList 筛选出的卡片
     *         cardList 欠费卡片
     *         amountBefore 选中数量
     *         amountAfter 公司持有并且不欠费卡片的数量
     *         msg 是否有欠费卡片 0 没有 1 有
     *         userList 划拨卡片的对象
     */
    @RequestMapping(value = "/chooseTransferCustomer.do")
    public ModelAndView chooseTransferCustomer(@RequestParam(value = "ICCID", required = false, defaultValue = "") String[] ICCID, int presentPage, HttpSession session){
        ModelAndView mv = new ModelAndView();
        int ID = (int) session.getAttribute("ID");
        int priority = (int) session.getAttribute("priority");
        if (priority==1){
            mv.addObject("msg","该用户没有权限");
            mv.setViewName("/result.jsp");
            return mv;
        }
        TreeSet<String> set = new TreeSet<>();
        set = (TreeSet<String>) session.getAttribute("ICCID");
        if (set.size()==0){
            session.setAttribute("ICCID", null);
        }
        if (session.getAttribute("ICCID") != null && ICCID.length > 0) {
            set = (TreeSet<String>) session.getAttribute("ICCID");
            if (cardService.queryServerByICCID(ICCID[0]) != cardService.queryServerByICCID(set.first())) {
                set = new TreeSet<String>(Arrays.asList(ICCID));
                session.setAttribute("ICCID", set);
            } else {
                List<String> ICCIDList =
                        cardService.queryICCIDByServerAndPage(cardService.queryServerByICCID(set.first()), null, presentPage);
                List<String> ICCIDListx = Arrays.asList(ICCID);
                set.addAll(ICCIDListx);
                for (String iccid : ICCIDList) {
                    if (!ICCIDListx.contains(iccid)) {
                        if (set.contains(iccid)) {
                            set.remove(iccid);
                        }
                    }
                }
            }
        }else if (session.getAttribute("ICCID") != null && ICCID.length == 0) {
            List<String> ICCIDList =
                    cardService.queryICCIDByServerAndPage(cardService.queryServerByICCID(set.first()), null, presentPage);
            for (String iccid : ICCIDList) {
                if (set.contains(iccid)) {
                    set.remove(iccid);
                }
            }
        }else if (session.getAttribute("ICCID") == null && ICCID.length > 0) {
            session.setAttribute("ICCID", new TreeSet<String>(Arrays.asList(ICCID)));
            set.addAll(Arrays.asList(ICCID));
        }else if (session.getAttribute("ICCID") == null){
            mv.addObject("msg", "没有选中卡片，请选择");
            mv.setViewName("/result.jsp");
            return mv;
        }
        int j = 0;
        String ICCIDx[] = new String[set.size()];
        for (String s : set) {
            ICCIDx[j++] = s;
        }
        session.setAttribute("ICCID", set);
        // 筛选出公司持有的卡片
        List<String> ICCIDList1 = cardService.judgeIdIsAlone(ICCIDx, 0);
        // System.out.println("公司持有的卡片");
        // System.out.println(ICCIDList1);
        // 卡片均非公司所有
        if (ICCIDList1.isEmpty()){
            // 您所选择的卡片均非公司所有，无法划拨
            // System.out.println("您所选择的卡片均非公司所有，无法划拨");
            mv.addObject("msg", "您所选择的卡片均非公司所有，请重新选择");
            mv.setViewName("/result.jsp");
            return mv;
        }
        // 不欠费的卡片的ICCID
        List<String> ICCIDList2 = cardService.checkCurrentChargeHighThan0(ICCIDList1);
        // System.out.println("不欠费的卡片");
        // System.out.println(ICCIDList2);
        if (ICCIDList2.isEmpty()){
            mv.addObject("msg", "您所选择的卡片均不符合条件，请重新选择");
            mv.setViewName("/result.jsp");
            return mv;
        }
        // 欠费卡片
        List<Card> cardList = cardService.checkCurrentChargeLessThan0(ICCIDList1);
        // 筛选出划拨对象（仅过滤掉公司管理员）
        List<User> userList = userService.queryAllUserWithoutRoot(rootID);
        userList = userService.queryUserWithNoProcessingTrade(userList);
        // System.out.println("划拨对象");
        // System.out.println(userList);
        mv.addObject("amountBefore",ICCIDx.length);
        mv.addObject("amountAfter",ICCIDList2.size());
        mv.addObject("ICCIDList", ICCIDList2);
        // 判断是否有可选商家
        if (userList.size() == 0){
            mv.addObject("msg", "没有可供划拨的商家，请查看卡片购买订单");
            mv.setViewName("/result.jsp");
            return mv;
        }else{
            mv.addObject("userList",userList);
        }
        // 判断是否有欠费卡片
        if (cardList.isEmpty()){
            mv.addObject("msg", "0");
        }else{
            mv.addObject("cardList", cardList);
            mv.addObject("msg", "1");
        }
        mv.setViewName("/dataManagement/cardTransfer.jsp");
        return mv;
    }

    /**
     * 划拨卡片
     * @param ICCID 卡片对应的ICCID
     * @param session 用户在服务器的仓库
     * @param user_ID 用户对应ID
     * @return 卡片信息
     */
    @RequestMapping(value = "/transferCardToCustomer.do")
    @ResponseBody
    public Map<String,Object> transferCardToCustomer(String ICCID[], int user_ID, int trade_ID, HttpSession session){
        Map<String,Object> map = new HashMap<>();
        String msg = null;
        int ID = (int) session.getAttribute("ID");
        int priority = (int) session.getAttribute("priority");
        if (priority==1){
            msg = "该用户没有权限";
            map.put("msg",msg);
            return map;
        }
        double num = cardService.transferCardToCustomer(ICCID, user_ID, trade_ID);
        if (num > 0) {
            msg = "余额不足，请充值，需要的总金额为"+num;
        } else if (num == -1) {
            msg = "划拨卡片成功";
        } else if (num == -2) {
            msg = "更新信息失败";
        } else if (num == -3){
            msg = "更新信息失败";
        } else if (num == -4){
            msg = "更新信息失败";
        } else if (num == -5){
            msg = "卡片数量不符，请重新选择划拨的卡片";
        }
        map.put("msg",msg);
        session.setAttribute("ICCID",null);
        return map;
    }

    /**
     * 查询连续ICCID
     * @param ICCID ICCID,包括'#'连码
     * @return 查询结果
     */
    @RequestMapping(value = "queryContinuousICCID.do")
    @ResponseBody
    public List<String> queryContinuousICCID(String ICCID){
        return cardService.queryContinuousICCID(ICCID,true);
    }

    /**
     * 卡片充值 选择金额
     * @param ICCID 续费卡片的ICCID,包括'#'连码
     * @param session 用户在服务器的仓库
     * @return user 包含账户余额信息
     *         ICCIDList 卡片ICCID
     */
    @RequestMapping(value = "/chooserAmountRechargeCard.do")
    public ModelAndView chooserAmountRechargeCard(String ICCID, HttpSession session){
        ModelAndView mv = new ModelAndView();
        int ID = (int) session.getAttribute("ID");
        User user = userService.queryOneUserByID(ID);
        List<String> ICCIDList = cardService.queryContinuousICCID(ICCID,true);
        if (ICCIDList.isEmpty()){
            mv.addObject("msg","符合条件的卡片为空，请重新选择");
            mv.setViewName("");
            return mv;
        }
        mv.addObject("user", user);
        mv.addObject("ICCIDList", ICCIDList);
        mv.setViewName("/businessManagement/cardsRenewaltwo.jsp");
        return mv;
    }

    /**
     * 卡片充值
     * @param ICCID 续费卡片的ICCID,包括'#'连码
     * @param session 用户在服务器的仓库
     * @param charge_trade 续费金额
     * @return 续费结果
     */
    @RequestMapping(value = "/rechargeCard.do")
    @ResponseBody
    public Map<String,Object> rechargeCard(String ICCID[], float charge_trade, HttpSession session){
        Map<String,Object> map = new HashMap<>();
        int ID = (int) session.getAttribute("ID");
        List<String> ICCIDList = new ArrayList<>();
        for (int i = 0; i<ICCID.length; i++){
            ICCIDList.add(ICCID[i]);
        }
        int num = cardService.rechargeCard(ICCIDList, ID, charge_trade);
        if (num == 0){
            map.put("msg","余额不足，请充值");
        }else if (num == 5){
            map.put("msg","续费卡片成功");
        }else{
            map.put("msg","更新信息失败，请稍后尝试");
        }
        return map;
    }

    /**
     * 回收卡片筛选卡片
     * 选择卡片并筛选卡片是否为用户所有并筛选出欠费卡片
     * @param ICCID 选中卡片的ICCID
     * @return ICCIDList 筛选出的卡片
     *         cardList 欠费卡片
     *         amountBefore 选中数量
     *         amountAfter 用户持有并且不欠费卡片的数量
     *         msg 是否有欠费卡片 0 没有 1 有
     */
    @RequestMapping(value = "/chooseRecoverCard.do")
    public ModelAndView chooseRecoverCard(@RequestParam(value = "ICCID", required = false, defaultValue = "") String ICCID[], int presentPage, HttpSession session){
        ModelAndView mv = new ModelAndView();
        int ID = (int) session.getAttribute("ID");
        int priority = (int) session.getAttribute("priority");
        if (priority==1){
            mv.addObject("msg","该用户没有权限");
            mv.setViewName("/result.jsp");
            return mv;
        }
        TreeSet<String> set = new TreeSet<>();
        set = (TreeSet<String>) session.getAttribute("ICCID");
        if (set.size()==0){
            session.setAttribute("ICCID", null);
        }
        if (session.getAttribute("ICCID") != null && ICCID.length > 0) {
            set = (TreeSet<String>) session.getAttribute("ICCID");
            if (cardService.queryServerByICCID(ICCID[0]) != cardService.queryServerByICCID(set.first())) {
                set = new TreeSet<String>(Arrays.asList(ICCID));
                session.setAttribute("ICCID", set);
            } else {
                List<String> ICCIDList =
                        cardService.queryICCIDByServerAndPage(cardService.queryServerByICCID(set.first()), null, presentPage);
                List<String> ICCIDListx = Arrays.asList(ICCID);
                set.addAll(ICCIDListx);
                for (String iccid : ICCIDList) {
                    if (!ICCIDListx.contains(iccid)) {
                        if (set.contains(iccid)) {
                            set.remove(iccid);
                        }
                    }
                }
            }
        }else if (session.getAttribute("ICCID") != null && ICCID.length == 0) {
            List<String> ICCIDList =
                    cardService.queryICCIDByServerAndPage(cardService.queryServerByICCID(set.first()), null, presentPage);
            for (String iccid : ICCIDList) {
                if (set.contains(iccid)) {
                    set.remove(iccid);
                }
            }
        }else if (session.getAttribute("ICCID") == null && ICCID.length > 0) {
            session.setAttribute("ICCID", new TreeSet<String>(Arrays.asList(ICCID)));
            set.addAll(Arrays.asList(ICCID));
        }else if (session.getAttribute("ICCID") == null){
            mv.addObject("msg", "没有选中卡片，请选择");
            mv.setViewName("/result.jsp");
            return mv;
        }
        int j = 0;
        String ICCIDx[] = new String[set.size()];
        for (String s : set) {
            ICCIDx[j++] = s;
        }
        session.setAttribute("ICCID", set);
        // 用户所有
        List<String> ICCIDList1 = cardService.judgeIdIsAlone(ICCIDx, 1);
        // 卡片均为公司所有
        if (ICCIDList1.isEmpty()){
            // 您所选择的卡片均为公司所有，无法回收
            // System.out.println("您所选择的卡片均为公司所有，无法划拨");
            mv.addObject("msg", "您所选择的卡片均为公司所有，请重新选择");
            mv.setViewName("/result.jsp");
            return mv;
        }
        // 不欠费的卡片的ICCID
        List<String> ICCIDList2 = cardService.checkCurrentChargeHighThan0(ICCIDList1);
        // 欠费卡片
        List<Card> cardList = cardService.checkCurrentChargeLessThan0(ICCIDList1);
        mv.addObject("amountBefore",ICCIDx.length);
        mv.addObject("amountAfter",ICCIDList2.size());
        mv.addObject("ICCIDList", ICCIDList2);
        // 判断是否有欠费卡片
        if (cardList.isEmpty()){
            mv.addObject("msg", "0");
        }else{
            mv.addObject("cardList", cardList);
            mv.addObject("msg", "1");
        }
        mv.setViewName("/dataManagement/cardRecover.jsp");
        return mv;
    }

    /**
     * 回收卡片
     * @param ICCID 卡片ICCID
     * @param session 用户在服务器的仓库
     * @return cardList 欠费卡片
     *
     */
    @RequestMapping(value = "/recoverCard.do")
    @ResponseBody
    public Map<String,Object> recoverCard(String ICCID[], HttpSession session){
        Map<String,Object> map = new HashMap<>();
        int ID = (int) session.getAttribute("ID");
        int priority = (int) session.getAttribute("priority");
        if (priority==1){
            map.put("msg","该用户没有权限");
            return map;
        }
        int num = cardService.recoverCard(ICCID);
        if (num == 0){
            map.put("msg","数据库更新错误");
            return map;
        }
        map.put("msg", "回收卡片成功");
        session.setAttribute("ICCID", null);
        return map;
    }

    /**
     * 用户购买卡片
     * @param session 用户在服务器的仓库
     * @return 1 用户余额不足
     *         4 订单更新错误
     *         6 执行成功
     */
    @RequestMapping(value = "/purchaseCard.do")
    @ResponseBody
    public Map<String,Object> purchaseCard(int amount, int server, HttpSession session){
        Map<String,Object> map = new HashMap<>();
        int ID = (int) session.getAttribute("ID");
        int priority = (int) session.getAttribute("priority");
/*        if (priority==0) {
            map.put("msg", "该用户没有权限");
            return map;
        }*/
        int num = cardService.purchaseCard(amount, ID, server);
        if (num == 1){
            map.put("msg","用户余额不足");
        }else if (num == 4){
            map.put("msg","订单更新错误");
        }else if (num == 6){
            map.put("msg","购买成功，卡片2小时内到户");
        }
        return map;
    }

    /**
     * 根据订单数据表的ID返回对应的卡片信息 订单详情
     * @param trade_ID 订单表的ID
     * @return 卡片
     */
    @RequestMapping(value = "/queryCardByTrade.do")
    @ResponseBody
    public List<Card> queryCardByTrade(Integer trade_ID){
        List<Card> cardList = cardService.queryCardByTrade(trade_ID);
        return cardList;
    }

    /**
     * 根据ICCID获取卡片详情信息
     * @param ICCID 卡片ICCID
     * @return 卡片详情网页
     */
    @RequestMapping(value = "/queryDetailedCardInfo.do")
    @ResponseBody
    public Map<String,Object> queryDetailedCardInfo(String ICCID){
        Map<String,Object> map = new HashMap();
        addTime1 = new Date();
        int card_ID = cardService.queryIDByICCID(ICCID);
        List<Set_CardDisplayInfo> set_cardDisplayInfoList = set_cardService.queryAllInfoByCardID(card_ID);
        CardDisplayInfo cardDisplayInfo = cardService.queryAllDisplayAllInfoByID(card_ID);
        if (cardDisplayInfo.getEnd_time().compareTo(addTime1.toString()) > 0){
            map.put("msg", "流量非实时同步，可能存在误差");
        }else{
            map.put("msg", "流量非实时同步，可能存在误差，卡片已到期");
        }
        StringBuilder time = new StringBuilder();
        if (!set_cardDisplayInfoList.isEmpty()){
            for (Set_CardDisplayInfo set_cardDisplayInfo:set_cardDisplayInfoList){
                String name = set_cardDisplayInfo.getSet_name();
                String start = set_cardDisplayInfo.getStart_time();
                String end = set_cardDisplayInfo.getEnd_time();
                time.append(name).append("：").append(start).append("到").append(end).append("\n");
            }
            time.deleteCharAt(time.length()-1);
        }
        map.put("time",time);
        map.put("set_cardDisplayInfoList",set_cardDisplayInfoList);
        map.put("cardDisplayInfo", cardDisplayInfo);
        map.put("ICCID", cardDisplayInfo.getICCID());
        return map;
    }

    /**
     * 登记卡片
     * @param card 卡片信息
     * @param session 用户在本地的仓库
     * @return 等级结果
     */
    @RequestMapping(value = "/registerCard.do")
    public ModelAndView registerCard(Card card, HttpSession session){
        ModelAndView mv = new ModelAndView();
        int ID = (int) session.getAttribute("ID");
        int priority = (int) session.getAttribute("priority");
        if (priority==1){
            mv.addObject("msg","该用户没有权限");
            mv.setViewName("/result.jsp");
            return mv;
        }
        card.setUser_ID(ID);
        List<String> ICCIDList = cardService.queryContinuousICCIDFromNull(card.getICCID());
        List<String> ICCIDList1 = cardService.judgeICCIDListIsExist(ICCIDList);
        if (!ICCIDList1.get(0).equals("null")){
            mv.addObject("msg", "部分ICCID已存在，无法登记");
            mv.addObject("ICCIDList", ICCIDList1);
            mv.setViewName("/result.jsp");
            return mv;
        }
        ICCIDList = cardService.insertCard(card, ICCIDList);
        mv.addObject("ICCIDList", ICCIDList);
        mv.addObject("amount", ICCIDList.size());
        mv.addObject("server",card.getServer());
        mv.setViewName("/businessManagement/insertNewcardtwo.jsp");
        return mv;
    }

    /**
     * 修改卡片的备注
     * @param ICCID 卡片的ICCID
     * @param remark 备注内容
     * @return msg 0 修改成功 还会携带remark内容
     *         msg 1 修改失败，请稍后尝试
     *         msg 2 修改失败，卡片均不存在
     */
    @RequestMapping(value = "/updateRemark.do")
    @ResponseBody
    public Map<String,Object> updateRemark(String ICCID, String remark){
        Map<String,Object> map = new HashMap<>();
        List<String> ICCIDList = cardService.queryContinuousICCID(ICCID, true);
        if (ICCIDList.isEmpty()){
            map.put("msg", "2");
            map.put("result", "卡片均不存在，请重新输入");
            return map;
        }
        int num = cardService.updateRemark(ICCIDList, remark);
        if (num==1){
            map.put("msg","1");
        } else{
            map.put("result", remark);
            map.put("msg","0");
        }
        return map;
    }


    @RequestMapping(value = "/test.do")
    public void test(){
        System.out.println(new QueryCardCondition());
    }
}
