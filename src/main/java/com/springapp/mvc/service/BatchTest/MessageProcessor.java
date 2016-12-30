package com.springapp.mvc.service.BatchTest;

import com.springapp.mvc.domain.User;
import org.springframework.batch.item.ItemProcessor;
import sun.plugin2.message.Serializer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by renshunhang on 2016/12/29.
 */
public class MessageProcessor implements ItemProcessor<User,List> {

    @Override
    public List process(User user) throws Exception {
        List message = new ArrayList();
        if (user.getAge() > 0) {
            System.out.println(user.getName() + ",Please come to police station!");
            message.add(user.getAge());
        }
        return message;
    }
}
