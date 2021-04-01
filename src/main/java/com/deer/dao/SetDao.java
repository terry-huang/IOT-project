package com.deer.dao;

import com.deer.domain.Set;

import java.util.List;

public interface SetDao {
    int insertSet(Set set);
    int updateSetProfit(float profit, int ID);
    List<Set> queryAllSetAllInfo();
}
