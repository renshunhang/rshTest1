package com.springapp.mvc.controller;

import com.springapp.mvc.common.OpbackResult;
import com.springapp.mvc.domain.TestDomain;
import com.springapp.mvc.service.TestService;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.concurrent.Callable;

/**
 * Created by renshunhang on 2016/7/21.
 */
@Controller
@RequestMapping("view")
public class viewController {
    @Autowired
    private TestService testService;

    @RequestMapping("toNewPage")
    public String viewNewPage(Model view){
        return "newPage";
    }

    @RequestMapping("query")
    public String query(Model view,@RequestParam(value = "id",required = false)Integer id){
        id = 1;
        TestDomain testDomain = testService.queryById(id);
        view.addAttribute("custNo",testDomain.getCustNo());
        OpbackResult result = new OpbackResult();
        result.setMessage("success");
        return "result";

    }

    @RequestMapping("queryResult")
    @ResponseBody
    public OpbackResult queryResult(Model view,@RequestParam(value = "id",required = false)Integer id,
                                    HttpServletRequest request,HttpServletResponse response){
        TestDomain testDomain = testService.queryById(id);
        view.addAttribute("custNo",testDomain.getCustNo());
        OpbackResult result = new OpbackResult();
        result.setStatus(OpbackResult.SUCCESS);
        result.setMessage("加载中。。。");
        return result;
    }

    @RequestMapping("async")
    @ResponseBody
    public OpbackResult async(Model view,Integer id){
        OpbackResult result = new OpbackResult();
        result.setStatus(OpbackResult.SUCCESS);
        result.setMessage("success");
        return result;
    }

}