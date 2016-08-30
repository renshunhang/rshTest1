package com.springapp.mvc;

import com.springapp.mvc.common.OpbackResult;
import com.springapp.mvc.domain.TestDomain;
import com.springapp.mvc.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
    public OpbackResult queryResult(Model view,@RequestParam(value = "id",required = false)Integer id){
        TestDomain testDomain = testService.queryById(id);
        view.addAttribute("custNo",testDomain.getCustNo());
        OpbackResult result = new OpbackResult();
        result.setStatus(OpbackResult.SUCCESS);
        result.setMessage("success");
        return result;
    }
}