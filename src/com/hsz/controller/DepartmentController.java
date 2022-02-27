package com.hsz.controller;

import com.hsz.bean.Department;
import com.hsz.bean.Msg;
import com.hsz.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {

    @Autowired
   private DepartmentService departmentService;


    /**
     * 返回部门信息
     * @return
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
//        查出都所有部门信息
        List<Department> depts = departmentService.getDepts();
        return Msg.success().add("depts",depts);
    }

}
