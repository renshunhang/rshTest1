package com.springapp.mvc.service.BatchTest;

import com.springapp.mvc.domain.TestDomain;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

/**
 * Created by renshunhang on 2016/12/30.
 */
public class WorldTest implements Tasklet{

    @Override
    public RepeatStatus execute(StepContribution stepContribution, ChunkContext chunkContext) throws Exception {
        System.out.println("hello:"+"renshunhang");
        return RepeatStatus.FINISHED;
    }
}
