/**
* 模仿天猫整站ssm 教程 为how2j.cn 版权所有
* 本教程仅用于学习使用，切勿用于非法用途，由此引起一切后果与本站无关
* 供购买者学习，请勿私自传播，否则自行承担相关法律责任
*/	

package com.digou.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.digou.pojo.Category;
import com.digou.pojo.Product;
import com.digou.pojo.Result;
import com.digou.service.CategoryService;
import com.digou.service.ProductImageService;
import com.digou.service.ProductService;
import com.digou.util.Page;
import com.digou.util.ResultUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("")
public class ProductController {
    @Autowired
    CategoryService categoryService;
    @Autowired
    ProductService productService;
    @Autowired
    ProductImageService productImageService;

    private static final Logger log = LoggerFactory.getLogger(ProductController.class);

    @ResponseBody
    @RequestMapping("admin_product_add")
    public Result<Product> add(Product p, HttpSession hs) {
        p.setStatus(1);
        p.setCreateDate(new Date());
        if ("".equals(p.getPromotePrice())||p.getPromotePrice()==null)
            p.setPromotePrice(p.getOriginalPrice());
        String singleName = hs.getAttribute("singleName").toString();
        p.setImageName(singleName); 
        productService.add(p);
        return new ResultUtil<Product>().setData(p);
    }





    @RequestMapping("admin_product_delete")
    public String delete(int id) {
        Product p = productService.get(id);
        productService.delete(id);
        return "redirect:admin_product_list?cid="+p.getCid();
    }

    @RequestMapping("editProducts")
    public String edit(Model model, int id,HttpSession hs) {
        Product p = productService.get(id);
        List<Category> cs= categoryService.list();
        Category cs1 = p.getCategory();
        model.addAttribute("p", p);
        model.addAttribute("cs",cs);
        model.addAttribute("cs1",cs1);
        hs.setAttribute("p",p);
        return "admin/admin_editProduct";
    }

    @ResponseBody
    @RequestMapping("admin_product_edit")
    public Result<Product> edit(Product p, HttpSession hs) {
        p.setStatus(1);
        p.setUpdateDate(new Date());
        log.error("-----------image："+p.getImageName());
        log.error("-----------image："+p.getImageName());
        productService.update(p);
        return new ResultUtil<Product>().setData(p);
    }
    @RequestMapping("admin_product_update")
    public String update(Product p) {
        productService.update(p);
        return "redirect:admin_product_list?cid="+p.getCid();
    }



    @RequestMapping("admin_product_list")
    public String list(int cid, Model model, Page page) {
        Category c = categoryService.get(cid);

        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Product> ps = productService.list(cid);

        int total = (int) new PageInfo<>(ps).getTotal();
        page.setTotal(total);
        page.setParam("&cid="+c.getId());

        model.addAttribute("ps", ps);
        model.addAttribute("c", c);
        model.addAttribute("page", page);

        return "admin/listProduct";
    }


    @RequestMapping("admin_product_listAll")
    public String listAll(Model model, Page page) {

        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Product> ps = productService.getAll();

        int total = (int) new PageInfo<>(ps).getTotal();
        page.setTotal(total);

        model.addAttribute("ps", ps);

        model.addAttribute("page", page);

        return "admin/admin_listProduct";
    }

    @ResponseBody()
    @RequestMapping(value = "admin_updateStatus/{id}/{status}")
    public String updateStatus(@PathVariable int id,
                               @PathVariable int status){

        Product p = new Product();
        p.setId(id);
        p.setUpdateDate(new Date());
        if (status==0){
            p.setStatus(1);
            productService.update(p);
        }
        if (status==1){
            p.setStatus(0);
            productService.update(p);
        }
        return "success";

    }





}

