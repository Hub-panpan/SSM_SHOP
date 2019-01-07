

package com.digou.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("")
public class PageController {
    @RequestMapping("registerPage")
    public String registerPage() {
        return "fore/register";
    }
    @RequestMapping("registerSuccessPage")
    public String registerSuccessPage() {
        return "fore/registerSuccess";
    }
    @RequestMapping("loginPage")
    public String loginPage() {
        return "fore/login";
    }
//    @RequestMapping("forealipay")
//    public String alipay(){
//        return "fore/alipay";
//    }

    //我自己添加的
    @RequestMapping("adminloginPage")
    public String foreadminlogin(){
        System.out.println("**********");

        return "admin/admin_login";
    }

    //    云小蜜客服API调用
    @RequestMapping("keFuPage")
    public String keFuPage(HttpSession session){

        return "fore/custom";
    }

    @RequestMapping("/toLogin")
    public String toLogin(){
        return "admin/admin_index";
    }

}

