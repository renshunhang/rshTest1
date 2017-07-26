package com.springapp.mvc.service.BatchTest;

import com.springapp.mvc.domain.User;
import org.springframework.batch.item.ItemProcessor;

import java.util.ArrayList;
import java.util.List;

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
