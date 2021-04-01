package com.deer.service;

import com.deer.domain.Set_Card;
import com.deer.vo.Set_CardDisplayInfo;

import java.util.List;

public interface Set_CardService {
    List<Set_CardDisplayInfo> queryAllInfoByCardID(int card_ID);
}
