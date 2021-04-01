package com.deer.dao;

import com.deer.domain.Set_Card;
import com.deer.vo.Set_CardDisplayInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface Set_CardDao {
    List<Set_CardDisplayInfo> queryAllInfoByCardID(@Param("Card_ID") int card_ID);
}
