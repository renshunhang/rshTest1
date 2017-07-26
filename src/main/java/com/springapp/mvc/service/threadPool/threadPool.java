package com.springapp.mvc.service.threadPool;

import com.springapp.mvc.domain.User;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;

/**
 * Created by renshunhang on 2017/3/15.
 * com.springapp.mvc.service.threadPool
 */
public class threadPool {

    public static void main(String args[]){
        long start = System.currentTimeMillis();
        try {
            for (int i=0;i<5;i++){
                String name = new threadPool().getData("tom");
                System.out.append(name);
            }
            long end = System.currentTimeMillis();
            System.out.println("串行执行结束，耗时："+(end-start));
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        try {
            new threadPool().exec("job");
        } catch (ExecutionException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }


    }

    public String getData(String name) throws InterruptedException {
        Thread.sleep(1000);
        return name;
    }

    void exec(final String name) throws ExecutionException, InterruptedException {
        //futureTasks 用来放每个执行的FutureTask
        List<FutureTask<String>> futureTasks = new ArrayList<FutureTask<String>>();
        //创建一个线程池
        ExecutorService service = Executors.newFixedThreadPool(10);

        long start = System.currentTimeMillis();
        //类似于run方法的实现，Callable是个接口，在call方法中写逻辑代码，call中的方法就是我们比较耗时的操作
        Callable<String> callable = new Callable<String>() {
            @Override
            public String call() throws Exception {
                Thread.sleep(1000);
                return name;
            }
        };
        //假如要调用5次这个方法，若是调用其他方法，则写多个callable方法即可
        for (int i =0;i<5;i++){
            FutureTask<String> futureTask = new FutureTask<String>(callable);
            //提交异步任务到线程池，由于是异步并行任务，这里不会阻塞
            service.submit(futureTask);
            futureTasks.add(futureTask);
        }
        Callable<List<User>> callable1 = new Callable<List<User>>() {
            @Override
            public List<User> call() throws Exception {
                List<User> list = new ArrayList<User>();
                Thread.sleep(1000);
                return list;
            }
        };
//        FutureTask<String> futureTask1= new FutureTask<String>(callable);
//        service.submit(futureTask1);
//        futureTasks.add(futureTask1);
//
//        FutureTask<String> futureTask2= new FutureTask<String>(callable1);
//        service.submit(futureTask2);
//        futureTasks.add(futureTask2);


        //futureTask.get()获取每个callable执行后的结果，返回类型由callable类型决定
        for (FutureTask<String> futureTask : futureTasks){
            System.out.append(futureTask.get());
        }
        long end = System.currentTimeMillis();
        System.out.println("并行耗时："+ (end-start));
    }
}
