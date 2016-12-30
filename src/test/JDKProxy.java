import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.springframework.cglib.proxy.Callback;
import org.springframework.cglib.proxy.Enhancer;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

/**
 * Created by renshunhang on 2016/8/31.
 */
public class JDKProxy implements InvocationHandler {

    private Object target;

    public JDKProxy(Object target) {
        this.target = target;
    }

    private void before(){
        System.out.println("before");
    }

    private  void after(){
        System.out.println("after");
    }

    @SuppressWarnings("unchecked")
    public <T> T getProxy(){
        return (T) Proxy.newProxyInstance(target.getClass().getClassLoader(),
                target.getClass().getInterfaces(),this);
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        before();
        Object result = method.invoke(target,args);
        after();
        return result;
    }
}
