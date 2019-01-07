/**
* 模仿天猫整站ssm 教程 为how2j.cn 版权所有
* 本教程仅用于学习使用，切勿用于非法用途，由此引起一切后果与本站无关
* 供购买者学习，请勿私自传播，否则自行承担相关法律责任
*/	

package com.digou.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import com.digou.pojo.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.digou.service.OrderItemService;
import com.digou.service.OrderService;
import com.digou.util.Page;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("")
public class OrderController {
    @Autowired
    OrderService orderService;
    @Autowired
    OrderItemService orderItemService;

    //okokok
    @RequestMapping("admin_showAllOrder.do")
    public String list(Model model, Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());

        List<Order> os= orderService.list();

        int total = (int) new PageInfo<>(os).getTotal();
        page.setTotal(total);

        orderItemService.fill(os);

        model.addAttribute("os", os);
        model.addAttribute("page", page);

//        return "admin/listOrder";
        return  "admin/admin_listOrder";

    }

    @RequestMapping("admin_order_delivery")
    public String delivery(Order o) throws IOException {
        o.setDeliveryDate(new Date());
        o.setStatus(OrderService.waitConfirm);
        orderService.update(o);
        return "redirect:admin_order_list";
    }

    String s=null;

    @RequestMapping("list_By_Admin")
    public String list_By_Admin(@RequestParam(value="status",required=false) String status,Model model, Page page) throws IOException {

        PageHelper.offsetPage(page.getStart(),page.getCount());
        if(status==null){
            status=s;
        }


        System.out.println("获取到：status:"+status);
        List<Order> os= orderService.list_By_Admin(status);

        int total = (int) new PageInfo<>(os).getTotal();
        page.setTotal(total);

        orderItemService.fill(os);

        s=status;
        model.addAttribute("os", os);
        model.addAttribute("page", page);

        model.addAttribute("s", status);
//        return "admin/listOrder";
        return  "admin/admin_listOrder";
    }



    @RequestMapping("admin_send_Order")
    public String send_order( Model model,@RequestParam("id") int oid) {
        System.out.println(oid);
        Order o = orderService.get(oid);
        o.setStatus(OrderService.waitConfirm);

        o.setDeliveryDate(new Date());
        orderService.update(o);

        return "redirect:admin_showAllOrder.do";
    }

    @RequestMapping("delete_Order")
    public String delete_Order( Model model,@RequestParam("oid") int oid) {
        System.out.println(oid);
        Order o = orderService.get(oid);
        o.setStatus(OrderService.delete);
        o.setConfirmDate(new Date());
        orderService.update(o);

        return "redirect:forebought";
    }

    @RequestMapping("admin_show_sinle_order")
    public String single_order( Model model,@RequestParam("id") int oid) {
        System.out.println(oid);
        Order o = orderService.get(oid);



        model.addAttribute("single_order",o);
        return "admin/admin_Order_Detail";

    }


    @RequestMapping("tui_huo")
    public String tui_huo( Model model,@RequestParam("oid") int oid) {
        Order o = orderService.get(oid);
        o.setStatus(OrderService.waitTuihuo);
        o.setConfirmDate(new Date());
        orderService.update(o);

        return "redirect:forebought";
    }


    @RequestMapping("yi_tui_huo")
    public String yi_tui_huo( Model model,@RequestParam("oid") int oid) {
        Order o = orderService.get(oid);
        o.setStatus(OrderService.yituihuo);
//        o.setConfirmDate(new Date());
        orderService.update(o);

        return "redirect:list_By_Admin";
    }



}

