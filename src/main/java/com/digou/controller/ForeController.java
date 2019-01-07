

package com.digou.controller;

import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.digou.pojo.*;
import com.digou.pojo.Collection;
import com.digou.service.*;
import com.digou.util.AlipayConfig;
import com.github.pagehelper.PageHelper;
import com.digou.pojo.*;
import com.digou.service.*;
import comparator.*;

import org.apache.commons.lang.math.RandomUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("")
public class ForeController {
    @Autowired
    CategoryService categoryService;
    @Autowired
    ProductService productService;
    @Autowired
    UserService userService;
    @Autowired
    ProductImageService productImageService;
    @Autowired
    PropertyValueService propertyValueService;
    @Autowired
    OrderService orderService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    ReviewService reviewService;
    @Autowired
    MemberService memberService;
    @Autowired
    CollectionService collectionService;


    private static final Logger log = LoggerFactory.getLogger(ForeController.class);


    @RequestMapping("forehome")
    public String home(Model model) {



        List<Category> cs= categoryService.list();
//        productService.fill(cs);
//        productService.fillByRow(cs);


         model.addAttribute("cs", cs);
        return "fore/home";
    }

    @RequestMapping("foreregister")
    public String register(Model model,User user) {
        String name =  user.getName();
        name = HtmlUtils.htmlEscape(name);
        user.setName(name);

        boolean exist = userService.isExist(name);
        
        if(exist){
            String m ="用户名已经被使用,不能使用";
            model.addAttribute("msg", m);
            return "fore/register";
        }
        userService.add(user);
        //新建用户登录表
        Member m=new Member();
        m.setMember_name(user.getName());
        //用户详情表
         memberService.add(m);

        return "redirect:registerSuccessPage";
    }

    //已经被我修改过　　得到用户
    @RequestMapping("forelogin")
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


//    /**    管理员 登录        */
//    @RequestMapping("adminadmin_login")
//            public String admin_login(@RequestParam("admin_name") String name, @RequestParam("admin_password") String password, Model model, HttpSession session) {
//            name = HtmlUtils.htmlEscape(name);
//              System.out.println("管理员登录："+name);
//            User user = userService.get(name,password);
//
//            if(null==user){
//                model.addAttribute("msg", "账号密码错误");
//                return "admin/admin_login";
//            }
//            session.setAttribute("admin", user);
//             return "admin/admin_index";
//        }

    @RequestMapping("adminlogoff")
    public String adminlogout( HttpSession session) {
        session.removeAttribute("admin");
        return "redirect:forehome";
    }


    @RequestMapping("forelogout")
    public String logout( HttpSession session) {
        session.removeAttribute("user");
        return "redirect:forehome";
    }

    @RequestMapping("foreproduct")
    public String product( int pid,HttpSession hs) {
        Product p = productService.get(pid);

//        List<ProductImage> productSingleImages = productImageService.list(p.getId(), ProductImageService.type_single);
//        List<ProductImage> productDetailImages = productImageService.list(p.getId(), ProductImageService.type_detail);
//        p.setProductSingleImages(productSingleImages);
//        p.setProductDetailImages(productDetailImages);

        List<PropertyValue> pvs = propertyValueService.list(p.getId());
        List<Review> reviews = reviewService.list(p.getId());
        productService.setSaleAndReviewNumber(p);
        User user = (User)hs.getAttribute("user");
        String username = "";
        if (user!=null)
            username = user.getName();
        Collection collection=collectionService.getPdSC(pid,username);
        log.error("----------------"+collection.getPid()+"-------"+collection.getScuname());
        if (collection==null||collection.getPid()==-1){
            hs.setAttribute("isShouChang","false");
        }else {
            hs.setAttribute("isShouChang","true");
        }
        hs.setAttribute("reviews", reviews);
        hs.setAttribute("p", p);
        hs.setAttribute("pvs", pvs);
        return "fore/product";
    }


    @RequestMapping("forecheckLogin")
    @ResponseBody
    public String checkLogin( HttpSession session) {
        User user =(User)  session.getAttribute("user");
        if(null!=user)
            return "success";
        return "fail";
    }
    @RequestMapping("foreloginAjax")
    @ResponseBody
    public String loginAjax(@RequestParam("name") String name, @RequestParam("password") String password,HttpSession session) {
        name = HtmlUtils.htmlEscape(name);
        User user = userService.get(name,password);

        if(null==user){
            return "fail";
        }
        session.setAttribute("user", user);
        return "success";
    }




    @RequestMapping("forecategory")
    public String category(int cid,String sort, Model model,HttpSession session) {
        Category c = categoryService.get(cid);
        productService.fill(c);
        productService.setSaleAndReviewNumber(c.getProducts());

        if(null!=sort){
            switch(sort){
                case "review":
                    Collections.sort(c.getProducts(),new ProductReviewComparator());
                    break;
                case "date" :
                    Collections.sort(c.getProducts(),new ProductDateComparator());
                    break;

                case "saleCount" :
                    Collections.sort(c.getProducts(),new ProductSaleCountComparator());
                    break;

                case "price":
                    Collections.sort(c.getProducts(),new ProductPriceComparator());
                    break;

                case "all":
                    Collections.sort(c.getProducts(),new ProductAllComparator());
                    break;
            }
        }
        session.setAttribute("showProduct","showProduct");
        model.addAttribute("c", c);
        return "fore/category";
    }

    @RequestMapping("foresearch")
    public String search( String keyword,Model model){

        PageHelper.offsetPage(0,20);
        List<Product> ps= productService.search(keyword);
        productService.setSaleAndReviewNumber(ps);
        model.addAttribute("ps",ps);
        return "fore/searchResult";
    }
    @RequestMapping("forebuyone")
    public String buyone(int pid, int num, HttpSession session) {
        Product p = productService.get(pid);
        int oiid = 0;

        User user =(User)  session.getAttribute("user");
        boolean found = false;
        List<OrderItem> ois = orderItemService.listByUser(user.getId());
        for (OrderItem oi : ois) {
            if(oi.getProduct().getId().intValue()==p.getId().intValue()){
                oi.setNumber(oi.getNumber()+num);
                orderItemService.update(oi);
                found = true;
                oiid = oi.getId();
                break;
            }
        }

        if(!found){
            OrderItem oi = new OrderItem();
            oi.setUid(user.getId());
            oi.setNumber(num);
            oi.setPid(pid);
            orderItemService.add(oi);
            oiid = oi.getId();
        }
        return "redirect:forebuy?oiid="+oiid;
    }

    @RequestMapping("forebuy")
    public String buy( Model model,String[] oiid,HttpSession session){
        List<OrderItem> ois = new ArrayList<>();
        float total = 0;

        for (String strid : oiid) {
            int id = Integer.parseInt(strid);
            OrderItem oi= orderItemService.get(id);
            total +=oi.getProduct().getPromotePrice()*oi.getNumber();
            ois.add(oi);
        }

        session.setAttribute("ois", ois);
        model.addAttribute("total", total);
        return "fore/buy";
    }
    @RequestMapping("foreaddCart")
    @ResponseBody
    public String addCart(int pid, int num, Model model,HttpSession session) {
        Product p = productService.get(pid);
        User user =(User)  session.getAttribute("user");
        boolean found = false;

        List<OrderItem> ois = orderItemService.listByUser(user.getId());
        for (OrderItem oi : ois) {
            if(oi.getProduct().getId().intValue()==p.getId().intValue()){
                oi.setNumber(oi.getNumber()+num);
                orderItemService.update(oi);
                found = true;
                break;
            }
        }


        if(!found){
            OrderItem oi = new OrderItem();
            oi.setUid(user.getId());
            oi.setNumber(num);
            oi.setPid(pid);
            orderItemService.add(oi);
        }
        return "success";
    }
    @RequestMapping("forecart")
    public String cart( Model model,HttpSession session) {
        User user =(User)  session.getAttribute("user");
        List<OrderItem> ois = orderItemService.listByUser(user.getId());
        model.addAttribute("ois", ois);
        return "fore/cart";
    }

    @RequestMapping("forechangeOrderItem")
    @ResponseBody
    public String changeOrderItem( Model model,HttpSession session, int pid, int number) {
        User user =(User)  session.getAttribute("user");
        if(null==user)
            return "fail";

        List<OrderItem> ois = orderItemService.listByUser(user.getId());
        for (OrderItem oi : ois) {
            if(oi.getProduct().getId().intValue()==pid){
                oi.setNumber(number);
                orderItemService.update(oi);
                break;
            }

        }
        return "success";
    }
    @RequestMapping("foredeleteOrderItem")
    @ResponseBody
    public String deleteOrderItem( Model model,HttpSession session,int oiid){
        User user =(User)  session.getAttribute("user");
        if(null==user)
            return "fail";
        orderItemService.delete(oiid);
        return "success";
    }

    @RequestMapping("forecreateOrder")
    public String createOrder(HttpSession session ,Order order){
        User user =(User)  session.getAttribute("user");
        String orderCode = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) + RandomUtils.nextInt(10000);
        order.setOrderCode(orderCode);
        order.setCreateDate(new Date());
        order.setUid(user.getId());
        order.setStatus(OrderService.waitPay);
        List<OrderItem> ois= (List<OrderItem>)  session.getAttribute("ois");
        float total =orderService.add(order,ois);
        session.setAttribute("oid",order.getId());
        session.setAttribute("total",total);
        return "redirect:forealipay?oid="+order.getId()+"&total="+total;
    }

    @RequestMapping(value = "forealipay")
    public String goAlipay(int oid, float total, HttpServletRequest request, HttpServletResponse response) throws Exception {
        User user =(User)  request.getSession().getAttribute("user");
        List<OrderItem> ot = orderItemService.getByoAndu(user.getId(),oid);
        String productName = ot.get(0).getProduct().getName();
        Order order = orderService.get(oid);

        //获得初始化的AlipayClient
        AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);

        //设置请求参数
        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
        alipayRequest.setReturnUrl(AlipayConfig.return_url);
        alipayRequest.setNotifyUrl(AlipayConfig.notify_url);

        //商户订单号，商户网站订单系统中唯一订单号，必填
        String out_trade_no = order.getOrderCode();
        //付款金额，必填
        String total_amount = String.valueOf(Float.valueOf(total));
        //订单名称，必填
        String subject = ot.get(0).getProduct().getName();
        //商品描述，可空
        String body = order.getUserMessage();

        // 该笔订单允许的最晚付款时间，逾期将关闭交易。取值范围：1m～15d。m-分钟，h-小时，d-天，1c-当天（1c-当天的情况下，无论交易何时创建，都在0点关闭）。 该参数数值不接受小数点， 如 1.5h，可转换为 90m。
        String timeout_express = "1c";

        alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\","
                + "\"total_amount\":\""+ total_amount +"\","
                + "\"subject\":\""+ subject +"\","
                + "\"body\":\""+ body +"\","
                + "\"timeout_express\":\""+ timeout_express +"\","
                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

        //请求
        String result = alipayClient.pageExecute(alipayRequest).getBody();
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        out.println(result);
        return null;
    }

    @ResponseBody
    @RequestMapping("forepayed")
    public ModelAndView payed(Model model, HttpSession hs) {
        ModelAndView mav = new ModelAndView();
        int oid = Integer.parseInt(hs.getAttribute("oid").toString());
        Order order = orderService.get(oid);
        order.setStatus(OrderService.waitDelivery);
        order.setPayDate(new Date());
        orderService.update(order);
        model.addAttribute("o", order);
        mav.setViewName("fore/payed");
        return mav;
    }

    @RequestMapping("forebought")
    public String bought( Model model,HttpSession session) {
        User user =(User)  session.getAttribute("user");
        List<Order> os= orderService.list(user.getId(),OrderService.delete);

        orderItemService.fill(os);

        model.addAttribute("os", os);

        return "fore/bought";
    }

    @RequestMapping("foreconfirmPay")
    public String confirmPay( Model model,int oid) {
        Order o = orderService.get(oid);
        orderItemService.fill(o);
        model.addAttribute("o", o);
        return "fore/confirmPay";
    }





    @RequestMapping("foreorderConfirmed")
    public String orderConfirmed( Model model,int oid) {
        Order o = orderService.get(oid);
        o.setStatus(OrderService.waitReview);
        o.setConfirmDate(new Date());
        orderService.update(o);
        return "fore/orderConfirmed";
    }




    @RequestMapping("foredeleteOrder")
    @ResponseBody
    public String deleteOrder( Model model,int oid){
        Order o = orderService.get(oid);
        o.setStatus(OrderService.delete);
        orderService.update(o);
        return "success";
    }



    //每个产品下面的 评论集合
    @RequestMapping("forereview")
    public String review( Model model,int oid) {
        //得到用户订单
        Order o = orderService.get(oid);
        //得到订单的商品
        orderItemService.fill(o);

        //得到一个商品
        Product p = o.getOrderItems().get(0).getProduct();

        //得到 此商品的 评论 集合

        List<Review> reviews = reviewService.list(p.getId());

        //得到此商品的 销售量   评论数
        productService.setSaleAndReviewNumber(p);

        //放到session中  到前台取值   商品 订单 评论的集合
        model.addAttribute("p", p);
        model.addAttribute("o", o);
        model.addAttribute("reviews", reviews);
        return "fore/review";
    }



    //确认收货   的时候 要评价
    @RequestMapping("foredoreview")
    public String doreview( Model model,HttpSession session,@RequestParam("oid") int oid,@RequestParam("pid") int pid  ,@RequestParam("price_value") float price_value    ,String content) {
        Order o = orderService.get(oid);
        o.setStatus(OrderService.finish);
        orderService.update(o);

        Product p = productService.get(pid);
        content = HtmlUtils.htmlEscape(content);

        //获取当前对象
        User user =(User)  session.getAttribute("user");
        Member member=(Member)session.getAttribute("current_member");


        //添加评论
        Review review = new Review();
        review.setContent(content);
        review.setPid(pid);
        review.setCreateDate(new Date());
        review.setUid(user.getId());
        reviewService.add(review);

        //给用户积分
        member.setMember_points(member.getMember_points()+(int)price_value);
        memberService.updateUserPoint(member);
        session.setAttribute("current_member",member);




        return "redirect:forereview?oid="+oid+"&showonly=true";
    }


    @RequestMapping("foreupdate")
    public String foreupdate( Model model,HttpSession session) {


        return "fore/updateMyinfo";
    }



















    //获取推荐的产品
    @RequestMapping("foretuijian")
    public String pdTuijian(HttpSession session) {

        List<Product> productList=new ArrayList<>();
        for (int pid:orderItemService.getTuijian()){
            productList.add(productService.get(pid));
        }
        session.setAttribute("c", productList);
        session.setAttribute("showProduct","tuijian");
        return "fore/category";
    }

    //获取狗嘴热的产品
    @RequestMapping("foreGouzuire")
    public String pdGouZuiRe(HttpSession session) {
        List<Product> productList=new ArrayList<>();
        for (int i:productService.getGouZuiRe()){
            productList.add(productService.get(i));
        }
        session.setAttribute("showProduct","gouZuiRe");
        session.setAttribute("c",productList);
        return "fore/category";
    }



            @RequestMapping("foremypoint")
            public String  foremypoint( Model model) {


                return "fore/shownMypoint";


            }




    @RequestMapping("go_chart1")
    public String  forechart1( Model model,@RequestParam("cid") int id,HttpSession session) {

            System.out.println(id);
            Category cc = categoryService.get(id);
            productService.fill(cc);
            productService.setSaleAndReviewNumber(cc.getProducts());

        Map<String,Integer> map1 = new HashMap();


        for (Product pp : cc.getProducts()) {

            map1.put(pp.getName(),pp.getStock());


        }



        session.setAttribute("map1",map1);

//
//            float arr[]={50, 20, 36, 10, 10, 30};
//
//            session.setAttribute("shuju",arr);


            session.setAttribute("admin_showProduct","admin_showProduct");
            model.addAttribute("cc", cc);

           return "admin/admin_chart1";

    }






    @RequestMapping("go_chart3")
    public String  forechart3( Model model,@RequestParam("cid") int id,HttpSession session) {

        System.out.println(id);
        Category cc = categoryService.get(id);
        productService.fill(cc);
        productService.setSaleAndReviewNumber(cc.getProducts());

        Map<String,Integer> map3 = new HashMap();


        for (Product pp : cc.getProducts()) {

            map3.put(pp.getName(),pp.getReviewCount());


        }



        session.setAttribute("map3",map3);




        session.setAttribute("admin_showProduct","admin_showProduct");
        model.addAttribute("cc", cc);

        return "admin/admin_chart3";

    }




    @RequestMapping("go_chart2")
    public String  forechart2( Model model,@RequestParam("cid") int id,HttpSession session) {

        System.out.println(id);
        Category cc = categoryService.get(id);
        productService.fill(cc);
        productService.setSaleAndReviewNumber(cc.getProducts());

        Map<String,Integer> map2 = new HashMap();


        for (Product pp : cc.getProducts()) {

            map2.put(pp.getName(),pp.getSaleCount());


        }



        session.setAttribute("map2",map2);


        float arr[]={50, 20, 36, 10, 10, 30};

        session.setAttribute("shuju",arr);


        session.setAttribute("admin_showProduct","admin_showProduct");
        model.addAttribute("cc", cc);

        return "admin/admin_chart2";

    }



}

