package com.hsz.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hsz.bean.Employee;
import com.hsz.bean.Msg;
import com.hsz.dao.EmployeeMapper;
import com.hsz.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {


    @Autowired
    EmployeeService employeeService;

    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkUser(@RequestParam("empName") String empName){
        //先判断用户的用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";

        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须是6-16位字母和数字的组合或者2-5位汉字！");
        }
        // 数据库用户名重复校验
        boolean b = employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg","用户名不可用！");
        }
    }

    /**
     * 员工保存
     * @return
     */

    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            //校验失败，返回失败，在模态框中显示校验失败的错误信息
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError f:errors) {
                System.out.println("错误的字段名"+f.getField());
                System.out.println("错误信息"+f.getDefaultMessage());
                map.put(f.getField(),f.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 拿到所有员工信息和分页信息已JSON格式放在响应体里
     * @param pn
     * @return
     */

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpWhitJSON(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        PageHelper.startPage(pn,5);
        List<Employee> employees = employeeService.getAll();
        PageInfo page = new PageInfo(employees,7);
        return Msg.success().add("pageInfo",page);

    }


    /**
     * 查询所有员工数据
     * @return
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){
        PageHelper.startPage(pn,5);
        List<Employee> employees = employeeService.getAll();
        PageInfo page = new PageInfo(employees,7);
        model.addAttribute("page",page);
        return "list";
    }
}
