package com.deer.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Trade_Card {
    private int trade_ID;   // 对应订单ID
    private int card_ID;    // 对应卡片ID
}
