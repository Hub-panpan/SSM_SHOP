

package com.digou.service;
 
import java.util.List;

import com.digou.pojo.Review;

public interface ReviewService {
     

    void add(Review c);

    void delete(int id);
    void update(Review c);
    Review get(int id);
    List list(int pid);
    List admin_all_list();

    int getCount(int pid);
}
