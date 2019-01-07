/**
* 模仿天猫整站ssm 教程 为how2j.cn 版权所有
* 本教程仅用于学习使用，切勿用于非法用途，由此引起一切后果与本站无关
* 供购买者学习，请勿私自传播，否则自行承担相关法律责任
*/	

package com.digou.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.digou.mapper.OrderItemMapper;
import com.digou.pojo.Order;
import com.digou.pojo.OrderItem;
import com.digou.pojo.OrderItemExample;
import com.digou.pojo.Product;
import com.digou.service.OrderItemService;
import com.digou.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class OrderItemServiceImpl implements OrderItemService {
    @Autowired
    OrderItemMapper orderItemMapper;
    @Autowired
    ProductService productService;

    @Override
    public void add(OrderItem c) {
        orderItemMapper.insert(c);
    }

    @Override
    public void delete(int id) {
        orderItemMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(OrderItem c) {
        orderItemMapper.updateByPrimaryKeySelective(c);
    }

    @Override
    public OrderItem get(int id) {
        OrderItem result = orderItemMapper.selectByPrimaryKey(id);
        setProduct(result);
        return result;
    }

    public List<OrderItem> list(){
        OrderItemExample example =new OrderItemExample();
        example.setOrderByClause("id desc");
        return orderItemMapper.selectByExample(example);

    }

    @Override
    public void fill(List<Order> os) {
        for (Order o : os) {
            fill(o);
        }
    }

    //获取该产品所有的出售量
    @Override
    public int getSaleCount(int pid) {
        OrderItemExample example =new OrderItemExample();
        example.createCriteria().andPidEqualTo(pid);
        List<OrderItem> ois =orderItemMapper.selectByExample(example);
        int result =0;
        for (OrderItem oi : ois) {
            result+=oi.getNumber();
        }
        return result;
    }

    @Override
    public List<OrderItem> listByUser(int uid) {
        OrderItemExample example =new OrderItemExample();
        example.createCriteria().andUidEqualTo(uid).andOidIsNull();
        List<OrderItem> result =orderItemMapper.selectByExample(example);
        setProduct(result);
        return result;
    }

    public void fill(Order o) {
        //添加查询语句进行查询orderItem表数据
        OrderItemExample example =new OrderItemExample();
        example.createCriteria().andOidEqualTo(o.getId());
        example.setOrderByClause("id desc");
        List<OrderItem> ois =orderItemMapper.selectByExample(example);
        setProduct(ois); //进行orderItem表中的映射产品添加

        float total = 0;
        int totalNumber = 0;
        for (OrderItem oi : ois) { //获取总价格和总数量
            total+=oi.getNumber()*oi.getProduct().getPromotePrice();
            totalNumber+=oi.getNumber();
        }
        o.setTotal(total);
        o.setTotalNumber(totalNumber);
        o.setOrderItems(ois);


    }
    //遍历订单映射表
    public void setProduct(List<OrderItem> ois){
        for (OrderItem oi: ois) {
            setProduct(oi);
        }
    }
    //根据订单映射表中的残品id获取产品对象
    private void setProduct(OrderItem oi) {
        Product p = productService.get(oi.getPid());
        oi.setProduct(p);  //映射一个对象
    }
    public List<Integer> getTuijian(){
        OrderItemExample orderItemExample0=new OrderItemExample();
        orderItemExample0.setOrderByClause("number asc");
        List<OrderItem> orderItemList=orderItemMapper.selectByExample(orderItemExample0);
        List<Integer> tuiJianPid=new ArrayList<>();
        int id;
        for(int i=0;tuiJianPid.size()<10;i++){//推荐10个
            id=orderItemList.get(i).getPid();
            if (!tuiJianPid.contains(id))
                tuiJianPid.add(id);
        }
        return tuiJianPid;
    }

    @Override
    public List<OrderItem> getByoAndu(int uid, int oid) {
        OrderItemExample example = new OrderItemExample();
        example.createCriteria().andUidEqualTo(uid).andOidEqualTo(oid);
        List<OrderItem> ois =orderItemMapper.selectByExample(example);
        setProduct(ois);
        return  ois;
    }

}
