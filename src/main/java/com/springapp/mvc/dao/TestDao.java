package com.springapp.mvc.dao;

import com.springapp.mvc.domain.TestDomain;
import org.springframework.stereotype.Repository;

/**
 * Created by renshunhang on 2016/7/28.
 */
@Repository
public interface TestDao {
    public TestDomain queryById(Integer id);

}
