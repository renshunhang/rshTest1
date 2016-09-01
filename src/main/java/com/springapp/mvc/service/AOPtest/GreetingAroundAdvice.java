package com.springapp.mvc.service.AOPtest;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.springframework.cglib.proxy.MethodProxy;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;

/**
 * Created by renshunhang on 2016/9/1.
 */
@Component
public class GreetingAroundAdvice implements MethodInterceptor {

    private void before(){
        System.out.println("before11111111");
    }

    private  void after(){
        System.out.println("after111111111");
    }


    @Override
    public Object invoke(MethodInvocation methodInvocation) throws Throwable {
        Object result=null;

        Method aaa =  methodInvocation.getMethod();

        String a =  methodInvocation.getArguments()[0].toString();
        if ("shunhang".equals(a)){
            System.out.println("1111111111");
        }else {
            System.out.println("222222222");
        }
        return result;
    }
}
