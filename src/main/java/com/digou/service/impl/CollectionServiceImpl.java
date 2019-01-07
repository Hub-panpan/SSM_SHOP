package com.digou.service.impl;



import com.digou.mapper.CollectionMapper;
import com.digou.mapper.MemberMapper;
import com.digou.pojo.*;
import com.digou.service.CollectionService;
import com.digou.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CollectionServiceImpl implements CollectionService {
    @Autowired
    CollectionMapper collectionMapper;


    @Override
    public List<Collection> list() {
        CollectionExample example =new CollectionExample();
        example.setOrderByClause("scId desc");
        return collectionMapper.selectByExample(example);
    }

    @Override
    public void add(Collection collection) {
        collectionMapper.insert(collection);
    }

    @Override
    public void delete(int scid) {
        collectionMapper.deleteByPrimaryKey(scid);
    }

    @Override
    public Collection get(int scid) {
        return collectionMapper.selectByPrimaryKey(scid);
    }

    //查询用户的收藏的商品 正序
    @Override
    public List<Collection> getUserSC(String uname) {
        CollectionExample collectionExample=new CollectionExample();
        CollectionExample.Criteria collectionExampleCriteria=collectionExample.createCriteria();
        collectionExampleCriteria.andScunameEqualTo(uname);
        return collectionMapper.selectByExample(collectionExample);
    }


    //查询某产品是否收藏
    public Collection getPdSC(int pid,String username){
        CollectionExample collectionExample=new CollectionExample();
        collectionExample.createCriteria().andPidEqualTo(pid).andScunameEqualTo(username);
        List<Collection> collectionList=new ArrayList<>();
        collectionList=collectionMapper.selectByExample(collectionExample);
        try{
            if (collectionList.get(0)==null)
                return new Collection();
        }catch (Exception e){
            Collection collection=new Collection();
            collection.setPid(-1);
            return collection;
        }

        return collectionList.get(0);
    }

    @Override
    public void update(Collection collection) {
        collectionMapper.updateByPrimaryKeySelective(collection);
    }

}


