import com.springapp.mvc.service.AOPtest.Greeting;
import com.springapp.mvc.service.AOPtest.GreetingImpl;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

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
        final Test test = new Test();
        test.set();
        System.out.println(test.getLong());
        System.out.println(test.getString());

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
        ExecutorService fixedThreadPool = Executors.newFixedThreadPool(3);
        for (int i=0;i<10;i++){
            final int index=i;
            fixedThreadPool.execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        System.out.println(index);
                        Thread.sleep(2000);
                    }catch (Exception e){
                        e.printStackTrace();
                    }
                }
            });
        }




//        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("spring/spring-servlet.xml");
//        Greeting greeting1 = (Greeting) applicationContext.getBean("greetProxy");
//        greeting1.sayHello("shunhang");

    }
}
