

package com.digou.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.digou.pojo.Category;
import com.digou.pojo.Review;
import com.digou.service.CategoryService;
import com.digou.service.ReviewService;
import com.digou.util.ImageUtil;
import com.digou.util.Page;
import com.digou.util.UploadedImageFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("")
public class ReviewController {
    @Autowired
    ReviewService reviewService;


    // 得到    后台的评论列表
    @RequestMapping("admin_review_list")
    public String list(Model model,Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Review> reviewList= reviewService.admin_all_list();

        int total = (int) new PageInfo<>(reviewList).getTotal();

        page.setTotal(total);
        model.addAttribute("reviewList", reviewList);
        model.addAttribute("page", page);
        return "admin/admin_listReview";
    }



    //后台   删除评论
    @RequestMapping("delete_review")
    public String delete_review(Model model, @RequestParam("review_id") int review_id){

        System.out.println(review_id);

        reviewService.delete(review_id);

        return "redirect:admin_review_list";
    }


}
