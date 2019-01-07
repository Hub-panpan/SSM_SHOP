

package com.digou.service;

import java.util.List;

import com.digou.pojo.Category;
import com.digou.pojo.Product;

public interface ProductService {
    void add(Product p);
    void delete(int id);
    void update(Product p);
    void updateByID(Product p);
    Product get(int id);
    List list(int cid);

    List<Product> getAll();

    void setFirstProductImage(Product p);

    void fill(List<Category> cs);

    void fill(Category c);

    void fillByRow(List<Category> cs);

    void setSaleAndReviewNumber(Product p);

    void setSaleAndReviewNumber(List<Product> ps);

    List<Product> search(String keyword);

    //推荐最热
    List<Integer> getGouZuiRe();



}
