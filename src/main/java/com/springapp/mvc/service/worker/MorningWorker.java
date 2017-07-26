package com.springapp.mvc.service.worker;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;


/**
 * Created by renshunhang on 2017/3/8.
 */
public class MorningWorker{
    Log log = LogFactory.getLog(MorningWorker.class);
    private volatile String param;

    public void morningTask() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                log.info("====================Quartz+param11111:"+param+Thread.currentThread());
                param = "123";

            }
        }).start();

        new Thread(new Runnable() {
            @Override
            public void run() {
                log.info("====================Quartz+param2222:"+param+Thread.currentThread());
                param = "123";
            }
        }).start();
    }

    public String getParam() {
        return param;
    }

    public void setParam(String param) {
        this.param = param;
    }

}
