

package com.digou.controller;

import java.util.HashMap;
import java.util.List;

import com.digou.pojo.Result;
import com.digou.pojo.User;
import com.digou.service.MemberService;
import com.digou.service.UserService;
import com.digou.util.ResultUtil;
import com.digou.pojo.Member;
import com.digou.util.GeetestLib;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.digou.util.Page;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller
@RequestMapping("")
public class UserController {
    @Autowired
    UserService userService;
    @Autowired
    MemberService memberService;







    @RequestMapping("admin_user_list")
    public String list(Model model, Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());

        /*
        List<User> us= userService.list();
        int total = (int) new PageInfo<>(us).getTotal();
        page.setTotal(total);
        model.addAttribute("us", us);

        */

        List<Member> mlist= memberService.list();

        int total = (int) new PageInfo<>(mlist).getTotal();
        page.setTotal(total);

        model.addAttribute("mlist", mlist);
        model.addAttribute("page", page);

//        return "admin/listUser";
        return "admin/admin_listUser";
    }


    //模糊查询
    @RequestMapping("admin_user_list_like")
    public String alike_search(Model model, Page page,@RequestParam("find_value") String find_value, @RequestParam("search_input") String input_value){
        PageHelper.offsetPage(page.getStart(),page.getCount());


        System.out.println("获得："+find_value);
        System.out.println(input_value);

        if(find_value.equals("All")){
            return "redirect:admin_user_list";
        }

        List<Member> mlist= memberService.alikeList(find_value,input_value);

        int total = (int) new PageInfo<>(mlist).getTotal();
        page.setTotal(total);

        model.addAttribute("mlist", mlist);
        model.addAttribute("page", page);

//        return "admin/listUser";
        return "admin/admin_listUser";
    }





    /**  用户中心表 　查看自己家的个人信息      */
        @RequestMapping("personalCenter")
        public String personalCenter(Model model, HttpSession session){
            //获取到当前在线User
            User u=(User)session.getAttribute("user");
            System.out.println("user personalcenter 登录得到user"+u.getName());

            Member current_member=memberService.get(u.getName());
            System.out.println(current_member.getMember_phone());


            model.addAttribute("current_member", current_member);

            session.setAttribute("current_member",current_member);
            //得到用户详情



            System.out.println("personalcenter.***　得到用户详情信息");

            return "fore/personalcenter";


        }









    //已经被我修改过　　得到用户
    @RequestMapping("fore")
    public String login(@RequestParam("name") String name, @RequestParam("password") String password, Model model, HttpSession session) {
        name = HtmlUtils.htmlEscape(name);
        User user = userService.get(name,password);

        if(null==user){
            model.addAttribute("msg", "账号密码错误");
            return "fore/login";
        }
        session.setAttribute("user", user);
        return "redirect:forehome";
    }


    @RequestMapping("member-updateselfinfo.do")
    public String updateMyinfo(Model model, HttpSession session,
                               @RequestParam("id") int id,
                               @RequestParam("member_phone") String m_phone,
                               @RequestParam("member_password") String member_password,
                               @RequestParam("member_name") String m_name,
                               @RequestParam("member_address") String m_address,
                               @RequestParam("member_points") int member_points,
                               @RequestParam("member_rights") int member_rights
                               ) {

                                System.out.println(m_phone);
                                System.out.println(m_address);
                                System.out.println(member_rights);



                                Member m=new Member();
                                m.setId(id);
                                m.setMember_phone(m_phone);
                                m.setMember_name(m_name);
                                m.setMember_address(m_address);
                                m.setMember_points(member_points);
                                m.setMember_rights(member_rights);

                                memberService.updateUserPoint(m);

//        model.addAttribute("m", m);

        return "redirect:personalCenter";


    }


    //管理员：功能 提升权限　降低权限　测试通过

    @RequestMapping("updateMemberRight")
    public String updateUserinfo(Model model, HttpSession session,
                                 @RequestParam("m_id") int id,
                                 @RequestParam("m_right") int right,
                                 @RequestParam("value") int value){

                System.out.println(id);
                System.out.println(right);
                System.out.println(value);

                Member m=new Member();
                m.setId(id);
                m.setMember_rights(right-value);

                memberService.updateUserRight(m);
                return "redirect:admin_user_list";


    }


    //管理员：功能 提升积分降低权限      *--* 暂时　没有测试

    @RequestMapping("updateMemberPoint")
    public String updateMemberPoint(Model model, HttpSession session,
                                 @RequestParam("m_id") int id,
                                 @RequestParam("m_point") int point,
                                 @RequestParam("value") int value){
        System.out.println(id);
        System.out.println(point);
        System.out.println(value);

        Member m=new Member();
        m.setId(id);
        m.setMember_rights(point-value);

        memberService.updateUserPoint(m);
        return "";


    }


    //极验初始化
    @ResponseBody
    @RequestMapping(value = "/geetestInit",method = RequestMethod.GET)
    public String geetesrInit(HttpServletRequest request){

        GeetestLib gtSdk = new GeetestLib(GeetestLib.id, GeetestLib.key,GeetestLib.newfailback);

        String resStr = "{}";

        //自定义参数,可选择添加
        HashMap<String, String> param = new HashMap<String, String>();

        //进行验证预处理
        int gtServerStatus = gtSdk.preProcess(param);

        //将服务器状态设置到session中
        request.getSession().setAttribute(gtSdk.gtServerStatusSessionKey, gtServerStatus);

        resStr = gtSdk.getResponseStr();

        return resStr;
    }

    //管理员登陆
    @ResponseBody
    @RequestMapping(value = "/admin/login",method = RequestMethod.POST)
    public Result<Object> login(String username, String password,
                                String challenge, String validate, String seccode,
                                HttpServletRequest request){

        //极验验证
        GeetestLib gtSdk = new GeetestLib(GeetestLib.id, GeetestLib.key,GeetestLib.newfailback);

        //从session中获取gt-server状态
        int gt_server_status_code = (Integer) request.getSession().getAttribute(gtSdk.gtServerStatusSessionKey);

        //自定义参数,可选择添加
        HashMap<String, String> param = new HashMap<String, String>();

        int gtResult = 0;

        if (gt_server_status_code == 1) {
            //gt-server正常，向gt-server进行二次验证
            gtResult = gtSdk.enhencedValidateRequest(challenge, validate, seccode, param);
            System.out.println(gtResult);
        } else {
            // gt-server非正常情况下，进行failback模式验证
            System.out.println("failback:use your own server captcha validate");
            gtResult = gtSdk.failbackValidateRequest(challenge, validate, seccode);
            System.out.println(gtResult);
        }
//        String md5Pass = DigestUtils.md5DigestAsHex(password.getBytes());
        if (gtResult == 1) {
            // 验证成功
            username = HtmlUtils.htmlEscape(username);
            User user = userService.get(username,password);

            if(user==null){
                return new ResultUtil<Object>().setErrorMsg("用户名或密码错误");
            }
            else {
                request.getSession().setAttribute("admin",user);
                return new ResultUtil<Object>().setData(null);
            }
            //MD5加密
        }
        else {
            // 验证失败
            return new ResultUtil<Object>().setErrorMsg("验证失败");
        }
    }

}
