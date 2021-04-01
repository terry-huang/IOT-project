package com.deer.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Set_Card {
    private int ID;
    private int card_ID;
    private int set_ID;
    private String start_time;
    private String end_time;
}
