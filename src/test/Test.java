import com.springapp.mvc.service.AOPtest.Greeting;
import com.springapp.mvc.service.AOPtest.GreetingImpl;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;

/**
 * Created by renshunhang on 2016/8/31.
 */
public class Test {
    //threadLocal
    ThreadLocal<Long> longThreadLocal = new ThreadLocal<Long>();
    ThreadLocal<String> stringThreadLocal = new ThreadLocal<String>();

    public void set(){
        longThreadLocal.set(Thread.currentThread().getId());
        stringThreadLocal.set(Thread.currentThread().getName());
    }
    public Long getLong(){
        return longThreadLocal.get();
    }
    public String getString(){
        return stringThreadLocal.get();
    }



    public static void main(String[] args) throws InterruptedException {
        final ExecutorService executorService = Executors.newCachedThreadPool();
        List<Future> list = new ArrayList<Future>();

        for (int i =0;i<10;i++) {
            Future future = executorService.submit(new TaskWithResult(i));
            list.add(future);
        }

        for (Future future:list){
            try {
                future.get();
                System.out.println("result=="+future.get());
            } catch (ExecutionException e) {
                e.printStackTrace();
                System.out.println("error");
            }
        }






//        final Test test = new Test();
//        test.set();
//        System.out.println(test.getLong());
//        System.out.println(test.getString());

//        int num=0;
//        while (true){
//            new Thread(new Runnable() {
//                @Override
//                public void run() {
//                    test.set();
//                    System.out.println(test.getLong());
//                    System.out.println(test.getString());
//                }
//            }).start();
//            num++;
//            System.out.println(num);
//        }



        //线程池
//        ExecutorService fixedThreadPool = Executors.newFixedThreadPool(3);
//        for (int i=0;i<10;i++){
//            final int index=i;
//            fixedThreadPool.execute(new Runnable() {
//                @Override
//                public void run() {
//                    try {
//                        System.out.println(index);
//                        Thread.sleep(2000);
//                    }catch (Exception e){
//                        e.printStackTrace();
//                    }
//                }
//            });
//        }




//        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("spring/spring-servlet.xml");
//        Greeting greeting1 = (Greeting) applicationContext.getBean("greetProxy");
//        greeting1.sayHello("shunhang");

    }

    static class TaskWithResult implements Callable<Integer>{
        private int i;

        public TaskWithResult(int i) {
            this.i = i;
        }

        @Override
        public Integer call() throws Exception {
            System.out.println("handle:" + i);
            return i;
        }
    }
}
