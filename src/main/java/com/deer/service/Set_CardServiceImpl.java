package com.deer.service;

import com.deer.dao.Set_CardDao;
import com.deer.domain.Set_Card;
import com.deer.vo.Set_CardDisplayInfo;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class Set_CardServiceImpl implements Set_CardService {

    @Resource
    private Set_CardDao set_cardDao;

    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date addTime;

    @Override
    public List<Set_CardDisplayInfo> queryAllInfoByCardID(int card_ID) {
        return set_cardDao.queryAllInfoByCardID(card_ID);
    }
}
