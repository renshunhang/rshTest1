import com.springapp.mvc.service.AOPtest.Greeting;
import com.springapp.mvc.service.AOPtest.GreetingImpl;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by renshunhang on 2016/8/31.
 */
public class Test {
    public static void main(String[] args){
//        Greeting greeting = new JDKProxy(new GreetingImpl()).getProxy();
//        greeting.sayHello();


        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("spring/spring-servlet.xml");
        Greeting greeting1 = (Greeting) applicationContext.getBean("greetProxy");
        greeting1.sayHello("shunhang");

    }
}
