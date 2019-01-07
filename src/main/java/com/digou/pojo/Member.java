

package com.digou.pojo;

public class Member {


    private Integer id;

    private  String   member_name;//用户名
    private  String   member_phone;   //用户电话
    private  String   member_address;//用户地址
    private  Integer   member_points;//用户积分
    private  Integer      member_rights;//用户权限






    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMember_name() {
        return member_name;
    }

    public void setMember_name(String member_name) {
        this.member_name = member_name;
    }

    public String getMember_phone() {
        return member_phone;
    }

    public void setMember_phone(String member_phone) {
        this.member_phone = member_phone;
    }

    public String getMember_address() {
        return member_address;
    }

    public void setMember_address(String member_address) {
        this.member_address = member_address;
    }

    public Integer getMember_points() {
        return member_points;
    }

    public void setMember_points(Integer member_points) {
        this.member_points = member_points;
    }

    public Integer getMember_rights() {
        return member_rights;
    }

    public void setMember_rights(Integer member_rights) {
        this.member_rights = member_rights;
    }
}
