package com.digou.service;

import com.digou.pojo.Collection;

import java.util.List;

public interface CollectionService {


    List<Collection> list();

    void add(Collection collection);

    void delete(int scid);

    Collection get(int scid);

    void update(Collection collection);

    List<Collection> getUserSC(String uname);

    Collection getPdSC(int pid,String username);
}
