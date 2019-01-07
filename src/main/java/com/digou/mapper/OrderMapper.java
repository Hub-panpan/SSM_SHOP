

package com.digou.mapper;

import com.digou.pojo.Order;
import com.digou.pojo.OrderExample;

import java.util.List;

public interface OrderMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Order record);

    int insertSelective(Order record);

    List<Order> selectByExample(OrderExample example);


    List<Order> selectByStatus(Order example);



    Order selectByPrimaryKey(Integer id);




    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);






}
