package com.deer.service;

import com.deer.dao.SetDao;
import com.deer.domain.Set;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SetServiceImpl implements SetService {

    @Resource
    private SetDao setDao;

    /**
     * 插入新的套餐信息
     * @param set 套餐信息（使用套餐对象）
     * @return 插入结果
     */
    @Override
    public int insertSet(Set set) {
        return setDao.insertSet(set);
    }

    /**
     * 修改套餐利润
     * @param profit 套餐利润
     * @param ID 套餐ID
     * @return 修改结果
     */
    @Override
    public int updateSetProfit(float profit, int ID) {
        return setDao.updateSetProfit(profit, ID);
    }

    /**
     * 获取所有套餐信息
     * @return 套餐信息
     */
    @Override
    public List<Set> queryAllSetAllInfo() {
        List<Set> setList = setDao.queryAllSetAllInfo();
        return setList;
    }
}
