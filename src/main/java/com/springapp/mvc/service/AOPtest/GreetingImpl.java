package com.springapp.mvc.service.AOPtest;

import org.springframework.stereotype.Component;

/**
 * Created by renshunhang on 2016/8/31.
 */
@Component
public class GreetingImpl implements Greeting {
    @Override
    public void sayHello(String name) {
        System.out.println("hello world"+name);
    }
}
