package com.springapp.mvc.service.impl;

import com.springapp.mvc.dao.TestDao;
import com.springapp.mvc.domain.TestDomain;
import com.springapp.mvc.service.TestService;
import com.sun.xml.internal.ws.developer.MemberSubmissionAddressing;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.batch.item.validator.ValidationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

/**
 * Created by renshunhang on 2016/7/28.
 */
@Service
public class TestServiceImpl implements TestService {
    Log log = LogFactory.getLog(TestServiceImpl.class);

    @Autowired
    private TestDao test;

    @Override
    @Cacheable(value="cacheDemo",key="#id")
    public TestDomain queryById(Integer id){
        return test.queryById(id);
    }

    public static <T> void validate(T t)throws ValidationException{
    }

}
