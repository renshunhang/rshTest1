package com.springapp.mvc.service.BatchTest;

import org.springframework.batch.item.ItemWriter;

import java.util.List;
import java.util.Map;

/**
 * Created by renshunhang on 2016/12/29.
 */
public class MessageWriter implements ItemWriter<List> {


    @Override
    public void write(List<? extends List> list) throws Exception {
        System.out.println("Results:");
        for (List name : list) {
            System.out.println(name);
        }
    }
}
