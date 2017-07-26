package com.springapp.mvc.common;

import org.springframework.cache.CacheManager;

/**
 * Created by renshunhang on 2017/3/23.
 * com.springapp.mvc.common
 */
public class EhcacheDemo {

    public static void main(String[] args) throws InterruptedException {
        AbstractCache abstractCache = new AbstractCache() {};
        abstractCache.put("123","456",10000);

        System.out.println(abstractCache.get("123"));
        Thread.sleep(9000);
        System.out.println(abstractCache.get("123"));
        Thread.sleep(2000);
        System.out.println(abstractCache.get("123"));
    }
}
