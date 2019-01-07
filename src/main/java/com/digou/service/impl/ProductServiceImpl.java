/**
* 模仿天猫整站ssm 教程 为how2j.cn 版权所有
* 本教程仅用于学习使用，切勿用于非法用途，由此引起一切后果与本站无关
* 供购买者学习，请勿私自传播，否则自行承担相关法律责任
*/	

package com.digou.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.digou.service.CategoryService;
import com.digou.service.ProductImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.digou.mapper.ProductMapper;
import com.digou.pojo.Category;
import com.digou.pojo.Product;
import com.digou.pojo.ProductExample;
import com.digou.pojo.ProductImage;
import com.digou.service.OrderItemService;
import com.digou.service.ProductService;
import com.digou.service.ReviewService;
@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    ProductMapper productMapper;
    @Autowired
    CategoryService categoryService;
    @Autowired
    ProductImageService productImageService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    ReviewService reviewService;

    @Override
    public void add(Product p) {
        productMapper.insert(p);
    }

    @Override
    public void delete(int id) {
        productMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Product p) {
        productMapper.updateByPrimaryKeySelective(p);
    }

    @Override
    public void updateByID(Product p) {
        productMapper.updateByPrimaryKey(p);
    }

    @Override
    public Product get(int id) {
        Product p = productMapper.selectByPrimaryKey(id);
        setFirstProductImage(p);
        setCategory(p);
        return p;
    }


    public void setCategory(List<Product> ps) {
        for (Product p : ps)
            setCategory(p);
    }

    public void setCategory(Product p) {
        int cid = p.getCid();
        Category c = categoryService.get(cid);
        p.setCategory(c);
    }

    @Override
    public List list(int cid) {
        ProductExample example = new ProductExample();
        example.createCriteria().andCidEqualTo(cid);
        example.setOrderByClause("id desc");
        List result = productMapper.selectByExample(example);
        setFirstProductImage(result);
        setCategory(result);
        return result;
    }

    @Override
    public void setFirstProductImage(Product p) {
        List<ProductImage> pis = productImageService.list(p.getId(), ProductImageService.type_single);
        if (!pis.isEmpty()) {
            ProductImage pi = pis.get(0);
            p.setFirstProductImage(pi);
        }
    }

    @Override
    public void fill(List<Category> cs) {
        for (Category c : cs) {
            fill(c);
        }
    }

    @Override
    public void fillByRow(List<Category> cs) {
        int productNumberEachRow = 8;
//        for (Category c : cs) {
//            List<Product> products =  c.getProducts();
//            List<List<Product>> productsByRow =  new ArrayList<>();
//            for (int i = 0; i < products.size(); i+=productNumberEachRow) {
//                int size = i+productNumberEachRow;
//                size= size>products.size()?products.size():size;
//                List<Product> productsOfEachRow =products.subList(i, size);
//                productsByRow.add(productsOfEachRow);
//            }
//            c.setProductsByRow(productsByRow);
//        }
    }

    @Override
    public void setSaleAndReviewNumber(Product p) {
        int saleCount = orderItemService.getSaleCount(p.getId());
        p.setSaleCount(saleCount);

        int reviewCount = reviewService.getCount(p.getId());
        p.setReviewCount(reviewCount);
    }

    @Override
    public void setSaleAndReviewNumber(List<Product> ps) {
        for (Product p : ps) {
            setSaleAndReviewNumber(p);
        }
    }

    @Override
    public List<Product> search(String keyword) {
        ProductExample example = new ProductExample();
        example.createCriteria().andNameLike("%" + keyword + "%");
        example.setOrderByClause("id desc");
        List result = productMapper.selectByExample(example);
        setFirstProductImage(result);
        setCategory(result);
        return result;
    }

    @Override
    public void fill(Category c) {
        List<Product> ps = list(c.getId());
        c.setProducts(ps);
    }

    public void setFirstProductImage(List<Product> ps) {
        for (Product p : ps) {
            setFirstProductImage(p);
        }
    }

    @Override
    public List<Product> getAll() {
        ProductExample productExample = new ProductExample();
        productExample.createCriteria();
        productExample.setOrderByClause("id desc");
        List<Product> result = productMapper.selectByExample(productExample);
        setFirstProductImage(result);
        setCategory(result);
        return result;
    }

    public List<Integer> getGouZuiRe() {
        ProductExample productExample = new ProductExample();
        Date crruentTime = new Date();
        Date endTime = new Date(crruentTime.getTime() - 1000000000);
        productExample.createCriteria().andCreateDateBetween(endTime, crruentTime);
        System.out.println(crruentTime + "   " + endTime);
        List<Product> productList = productMapper.selectByExample(productExample);
        List<Integer> integerList = new ArrayList<>();
        for (Product p : productList) {
            integerList.add(p.getId());
        }
        return integerList;
    }


}

