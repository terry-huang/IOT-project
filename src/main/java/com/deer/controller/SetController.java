package com.deer.controller;

import com.deer.domain.Set;
import com.deer.service.SetService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping(value = "/set")
public class SetController {

    @Resource
    private SetService setService;

    /**
     * 增加新套餐
     * @param set 套餐信息
     * @return 增加结果
     */
    @RequestMapping(value = "/insertSet.do")
    public ModelAndView insertSet(Set set){
        ModelAndView mv = new ModelAndView();
        int num = setService.insertSet(set);
        if (num != 1){
            System.out.println("套餐增加失败");
        }else {
            System.out.println("套餐增加成功");
        }
        return mv;
    }

    /**
     * 更新套餐的利润
     * @param ID 套餐ID
     * @param profit 套餐利润
     * @return 更新结果
     */
    @RequestMapping(value = "/updateSetProfit.do")
    public ModelAndView updateSetProfit(int ID, float profit){
        ModelAndView mv = new ModelAndView();
        int num = setService.updateSetProfit(profit, ID);
        if (num != 1){
            System.out.println("利润更新失败");
        }else {
            System.out.println("利润更新成功");
        }
        return mv;
    }

    /**
     * 获取所有套餐信息
     * @return 套餐信息
     */
    @RequestMapping(value = "queryAllSetAllInfo.do")
    public ModelAndView queryAllSetAllInfo(){
        ModelAndView mv = new ModelAndView();
        List<Set> setList = setService.queryAllSetAllInfo();
        mv.addObject("setList",setList);
        return mv;
    }
}
