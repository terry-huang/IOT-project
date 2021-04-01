package com.deer.service;

import com.deer.domain.Set;

import java.util.List;

public interface SetService {
    int insertSet(Set set);
    int updateSetProfit(float profit, int ID);
    List<Set> queryAllSetAllInfo();
}
