package com.hsz.test;

import com.github.pagehelper.PageInfo;
import com.hsz.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.Arrays;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:spring/applicationContext.xml", "classpath:spring/applicationContext.xml"})
public class Test2 {
    @Autowired
    WebApplicationContext context;
//虚拟MVC请求。获取处理结果
    MockMvc mockMvc;
    @Before
    public  void  initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }
    @Test
    public void test1() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders
                .get("/emps").param("pn", "1")).andReturn();
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("page");
        System.out.println(pageInfo.getPageNum());
        System.out.println(pageInfo.getPages());
        System.out.println(pageInfo.getTotal());
        System.out.println(Arrays.toString(pageInfo.getNavigatepageNums()));
        List<Employee> list = pageInfo.getList();
        for (Employee employee: list
             ) {
            System.out.println(employee.getdId() + employee.getEmpName());
        }


    }
}
