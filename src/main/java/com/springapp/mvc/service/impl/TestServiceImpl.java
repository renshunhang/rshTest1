package com.springapp.mvc.service.impl;

import com.springapp.mvc.dao.TestDao;
import com.springapp.mvc.domain.TestDomain;
import com.springapp.mvc.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by renshunhang on 2016/7/28.
 */
@Service
public class TestServiceImpl implements TestService {

    @Autowired
    private TestDao test;

    @Override
    public TestDomain queryById(Integer id){
        return test.queryById(id);
    }

}
