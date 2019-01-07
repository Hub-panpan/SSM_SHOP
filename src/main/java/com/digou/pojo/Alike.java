/**
* 模仿天猫整站ssm 教程 为how2j.cn 版权所有
* 本教程仅用于学习使用，切勿用于非法用途，由此引起一切后果与本站无关
* 供购买者学习，请勿私自传播，否则自行承担相关法律责任
*/	

package com.digou.pojo;

import java.util.List;

public class Alike {


    private String find_value;
    private String input_value;

    public Alike(String find_value, String input_value) {
        this.find_value = find_value;
        this.input_value = input_value;
    }

    public String getFind_value() {
        return find_value;
    }

    public void setFind_value(String find_value) {
        this.find_value = find_value;
    }

    public String getInput_value() {
        return input_value;
    }

    public void setInput_value(String input_value) {
        this.input_value = input_value;
    }
}
