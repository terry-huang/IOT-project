package com.deer.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private int ID;             // 用户ID
    private String name;        // 用户账号
    private String password;    // 用户账号密码
    private int priority;       // 用户权限
    private String company;     // 用户所属公司
    private double charge;      // 用户余额
    private String realName;    // 用户真实姓名
    private long IDnumber;      // 用户身份证
    private long QQ;            // 联系QQ
    private long Phone;         // 联系电话
    private String storeName;   // 店铺名称
    private int status;         // 店铺状态
}
