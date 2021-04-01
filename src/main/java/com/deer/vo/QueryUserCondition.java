package com.deer.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QueryUserCondition {
    private int startID;
    private int endID;
    private int priority;
    private int charge;
    private String storeName;
}
