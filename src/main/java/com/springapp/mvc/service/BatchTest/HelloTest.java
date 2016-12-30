package com.springapp.mvc.service.BatchTest;

import com.springapp.mvc.domain.TestDomain;
import com.springapp.mvc.domain.User;
import com.springapp.mvc.service.TestService;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;

/**
 * Created by renshunhang on 2016/12/29.
 */
public class HelloTest implements Tasklet{
    private String name;
    @Autowired
    private TestService testService;

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    @Override
    public RepeatStatus execute(StepContribution stepContribution, ChunkContext chunkContext) throws Exception {
        System.out.println("hello:");
        return RepeatStatus.FINISHED;
    }
}
