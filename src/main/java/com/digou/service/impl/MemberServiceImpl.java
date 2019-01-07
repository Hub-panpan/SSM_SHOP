
package com.digou.service.impl;

import com.digou.mapper.MemberMapper;
import com.digou.pojo.Alike;
import com.digou.pojo.Member;
import com.digou.pojo.MemberExample;
import com.digou.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {
    @Autowired
    MemberMapper memberMapper;

    @Override
    public void add(Member u) {
        memberMapper.insert(u);
    }

    @Override
    public void delete(int id) {
        memberMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Member u) {
        memberMapper.updateByPrimaryKey(u);
    }

    //显示所有
    public List<Member> list(){
        MemberExample example =new MemberExample();
                    //被注释掉的　代码可以实现倒序　　用在热卖商品当中
                      //        example.setOrderByClause("id desc");
        example.setOrderByClause("id desc");
        return memberMapper.selectByExample(example);

    }


    //模糊查询
    @Override
    public List alikeList(String find_value,String input_value) {
        Alike alike=new Alike(find_value,input_value);
        //被注释掉的　代码可以实现倒序　　用在热卖商品当中
        //        example.setOrderByClause("id desc");
        System.out.println("*"+find_value);

        System.out.println("*"+find_value);
        return memberMapper.selectByExampleAlike(alike);
    }


    @Override
    public boolean isExist(String name) {
        MemberExample example =new MemberExample();
        example.createCriteria().andNameEqualTo(name);
        List<Member> result= memberMapper.selectByExample(example);
        if(!result.isEmpty())
            return true;
        return false;

    }

    @Override
    public Member get(String member_name) {
//        MemberExample example =new MemberExample();
//        example.createCriteria().andNameEqualTo(member_name);

        Member  m= memberMapper.selectUserByName(member_name);

//        if(result.isEmpty())
//            return null;
//        return result.get(0);


        System.out.println(m.getMember_address());

        return  m;
    }



    @Override
    public boolean updateUserRight(Member m) {

        memberMapper.updateByPrimaryKeySelective(m);




        return true;
    }

    @Override
    public boolean updateUserPoint(Member m) {

        memberMapper.updateByPrimaryKeySelective(m);

        return  true;
    }
}

