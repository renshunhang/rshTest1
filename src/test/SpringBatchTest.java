import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersInvalidException;
import org.springframework.batch.core.launch.support.SimpleJobLauncher;
import org.springframework.batch.core.repository.JobExecutionAlreadyRunningException;
import org.springframework.batch.core.repository.JobInstanceAlreadyCompleteException;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.repository.JobRestartException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.core.task.SimpleAsyncTaskExecutor;

import java.util.Currency;

/**
 * Created by renshunhang on 2016/12/29.
 */
public class SpringBatchTest {
    public static void main(String[] args){
        ApplicationContext context = new ClassPathXmlApplicationContext("classpath:spring/spring-batch.xml");
        SimpleJobLauncher simpleJobLauncher = new SimpleJobLauncher();
        simpleJobLauncher.setJobRepository((JobRepository) context.getBean("jobRepository"));
        simpleJobLauncher.setTaskExecutor(new SimpleAsyncTaskExecutor());

        try {
            System.out.println("batch handle begin==================");
            long start = System.currentTimeMillis();
            System.out.println(start);
            JobExecution result = simpleJobLauncher.run((Job)context.getBean("messageJob"), new JobParameters());
            System.out.println(result);
            System.out.println(System.currentTimeMillis()-start);
            System.out.println("batch handle end==================");
        } catch (JobExecutionAlreadyRunningException e) {
            e.printStackTrace();
        } catch (JobRestartException e) {
            e.printStackTrace();
        } catch (JobInstanceAlreadyCompleteException e) {
            e.printStackTrace();
        } catch (JobParametersInvalidException e) {
            e.printStackTrace();
        }

    }
}
