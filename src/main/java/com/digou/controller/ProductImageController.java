package com.digou.controller;

import com.digou.pojo.KindEditorResult;
import com.digou.pojo.Product;
import com.digou.pojo.Result;
import com.digou.service.ProductImageService;
import com.digou.service.ProductService;
import com.digou.util.ImageUtil;
import com.digou.util.ResultUtil;
import com.digou.util.getExtension;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;


@Controller
@RequestMapping("")
public class ProductImageController {
    @Autowired
    ProductService productService;

    @Autowired
    ProductImageService productImageService;

    private static final Logger log = LoggerFactory.getLogger(ProductImageController.class);

    //WebUploader图片上传
    @ResponseBody
    @RequestMapping(value = "/image/imageUpload",method = RequestMethod.POST)
    public Result<Object> uploadFile(@RequestParam("file") MultipartFile files, HttpSession hs) {
        String fileName = files.getOriginalFilename();
        String imageFolder = hs.getServletContext().getRealPath("img/productSingle_middle/");
        File f = new File(imageFolder, fileName);
        if (f.exists()){
            return new ResultUtil<Object>().setErrorMsg("图片已存在，请改名后重新上传！");
        }
        String imagePath="";
        //获取父目录
        f.getParentFile().mkdirs();
        //获取文件扩展名
        String ex = getExtension.extension(fileName);
        try {
            files.transferTo(f);
            BufferedImage img = ImageUtil.changeImage(f);
            ImageIO.write(img, ex, f);
            ImageUtil.resizeImage(f, 217, 190, f);
            hs.setAttribute("singleName",fileName);
            imagePath = imageFolder+fileName;
        }catch (Exception e){
            e.printStackTrace();
        }
        return new ResultUtil<Object>().setData(imagePath);
    }

    @ResponseBody
    @RequestMapping(value = "/editImage/imageUpload",method = RequestMethod.POST)
    public Result<Object> uploadImage(@RequestParam("file") MultipartFile files, HttpSession hs) {
        Product p = (Product)hs.getAttribute("p");
        log.info("----------图片："+p.getImageName()+"-----------");
        String fileName = files.getOriginalFilename();
        String imageFolder = hs.getServletContext().getRealPath("img/productSingle_middle/");
        //删除以前的缩略图
        if (p!=null){
            File file = new File(imageFolder,p.getImageName());
            if (file.exists()&&file.isFile())
                file.delete();
        }
        File f = new File(imageFolder, fileName);
        if (f.exists()){
            return new ResultUtil<Object>().setErrorMsg("图片已存在，请改名后重新上传！");
        }
        String imagePath="";
        //获取父目录
        f.getParentFile().mkdirs();
        //获取文件扩展名
        String ex = getExtension.extension(fileName);
        try {
            files.transferTo(f);
            BufferedImage img = ImageUtil.changeImage(f);
            ImageIO.write(img, ex, f);
            ImageUtil.resizeImage(f, 217, 190, f);
            hs.setAttribute("singleName",fileName);
            imagePath = imageFolder+fileName;
        }catch (Exception e){
            e.printStackTrace();
        }
        return new ResultUtil<Object>().setData(imagePath);
    }

    //kindeditor上传
    @ResponseBody
    @RequestMapping(value = "/kindeditor/imageUpload",method = RequestMethod.POST)
    public KindEditorResult kindeditor(@RequestParam("imgFile") MultipartFile files, HttpSession hs) {
        KindEditorResult kindEditorResult=new KindEditorResult();
        String fileName = files.getOriginalFilename();
        String imageFolder = hs.getServletContext().getRealPath("img/productDetailed/");
        File f = new File(imageFolder, fileName);
        if (f.exists()){
            kindEditorResult.setError(1);
            kindEditorResult.setMessage("图片已存在，请重新上传！");
            return kindEditorResult;
        }
        String imagePath="";
        //获取父目录
        f.getParentFile().mkdirs();
        //获取文件扩展名
        String ex = getExtension.extension(fileName);
        try {
            files.transferTo(f);
            imagePath = "img/productDetailed/"+fileName;
            BufferedImage img = ImageUtil.changeImage(f);
            ImageIO.write(img, ex, f);
            ImageUtil.resizeImage(f, 217, 190, f);
            kindEditorResult.setError(0);
            kindEditorResult.setUrl(imagePath);
            return kindEditorResult;
        }catch (Exception e){
            e.printStackTrace();
        }
        kindEditorResult.setError(1);
        kindEditorResult.setMessage("上传失败");
        return kindEditorResult;
    }


  /*  @RequestMapping("admin_productImage_add")
    public String add(ProductImage  pi, HttpSession session, UploadedImageFile uploadedImageFile) {
        productImageService.add(pi);
        String fileName = pi.getId()+ ".jpg";
        String imageFolder;
        String imageFolder_small=null;
        String imageFolder_middle=null;
        if(ProductImageService.type_single.equals(pi.getType())){
            imageFolder= session.getServletContext().getRealPath("img/productSingle");
            imageFolder_small= session.getServletContext().getRealPath("img/productSingle_small");
            imageFolder_middle= session.getServletContext().getRealPath("img/productSingle_middle");
        }
        else{
            imageFolder= session.getServletContext().getRealPath("img/productDetail");
        }

        File f = new File(imageFolder, fileName);
        f.getParentFile().mkdirs();
        try {
            uploadedImageFile.getImage().transferTo(f);
            BufferedImage img = ImageUtil.changeImage(f);
            ImageIO.write(img, "jpg", f);

            if(ProductImageService.type_single.equals(pi.getType())) {
                File f_small = new File(imageFolder_small, fileName);
                File f_middle = new File(imageFolder_middle, fileName);

                ImageUtil.resizeImage(f, 56, 56, f_small);
                ImageUtil.resizeImage(f, 217, 190, f_middle);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:admin_productImage_list?pid="+pi.getPid();
    }

    @RequestMapping("admin_productImage_delete")
    public String delete(int id,HttpSession session) {
        ProductImage pi = productImageService.get(id);

        String fileName = pi.getId()+ ".jpg";
        String imageFolder;
        String imageFolder_small=null;
        String imageFolder_middle=null;

        if(ProductImageService.type_single.equals(pi.getType())){
            imageFolder= session.getServletContext().getRealPath("img/productSingle");
            imageFolder_small= session.getServletContext().getRealPath("img/productSingle_small");
            imageFolder_middle= session.getServletContext().getRealPath("img/productSingle_middle");
            File imageFile = new File(imageFolder,fileName);
            File f_small = new File(imageFolder_small,fileName);
            File f_middle = new File(imageFolder_middle,fileName);
            imageFile.delete();
            f_small.delete();
            f_middle.delete();

        }
        else{
            imageFolder= session.getServletContext().getRealPath("img/productDetail");
            File imageFile = new File(imageFolder,fileName);
            imageFile.delete();
        }


        productImageService.delete(id);


        return "redirect:admin_productImage_list?pid="+pi.getPid();
    }

    @RequestMapping("admin_productImage_list")
    public String list(int pid, Model model) {
        Product p =productService.get(pid);
        List<ProductImage> pisSingle = productImageService.list(pid, ProductImageService.type_single);
        List<ProductImage> pisDetail = productImageService.list(pid, ProductImageService.type_detail);


        model.addAttribute("p", p);
        model.addAttribute("pisSingle", pisSingle);
        model.addAttribute("pisDetail", pisDetail);

        return "admin/listProductImage";
    }*/
}

