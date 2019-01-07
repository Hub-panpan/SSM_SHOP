

package com.digou.service;

import com.digou.pojo.Member;

import java.util.List;

public interface MemberService {
    void add(Member c);
    void delete(int id);
    void update(Member c);
    Member get(String name);
    List list();
    List alikeList(String find_value, String input_value);

    boolean isExist(String name);



    //用户管理更新权限
    boolean updateUserRight(Member m);
    //用户管理更新积分
    boolean updateUserPoint(Member m);


}



