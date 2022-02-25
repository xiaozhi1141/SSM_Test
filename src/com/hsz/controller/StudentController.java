package com.hsz.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hsz.bean.Book;
import com.hsz.bean.BookExample;
import com.hsz.bean.Student;
import com.hsz.dao.BookMapper;
import com.hsz.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Arrays;
import java.util.List;

@Controller
public class StudentController {
    @Autowired
    StudentService studentService;
    @Autowired
    BookMapper bookMapper;
        @RequestMapping("/hello")
        public String test1(@RequestParam("id") Integer id, Model model){
            Student student = studentService.getStudent(id);
            model.addAttribute("student",student);
            return "success";
        }

    @RequestMapping("/hello1")
    public String test2(@RequestParam("id") Integer id, Model model){
        Student student = studentService.getStudent(id);
        model.addAttribute("student",student);
        return "success";
    }

    @RequestMapping("/hello2")
    public String test3(@RequestParam("page") Integer page, Model model){
        BookExample bookExample = new BookExample();
        bookExample.setOrderByClause("id");
        PageHelper.startPage(page,10);
        List<Book> books = bookMapper.selectByExample(bookExample);
//将分页的list放入PageInfo中
        PageInfo<Book> bookPageInfo = new PageInfo<>(books,6);
//        第二个参数是要连续显示的页码
        System.out.println("当前页码"+bookPageInfo.getPageNum());
        System.out.println("页的大小"+bookPageInfo.getPageSize());
        System.out.println("当前页第一条记录的序号"+bookPageInfo.getStartRow());
        System.out.println("当前页最后一条记录的序号"+bookPageInfo.getEndRow());
        System.out.println("总记录数"+bookPageInfo.getTotal());
        System.out.println( "总页码"+bookPageInfo.getPages());
        System.out.println("是否是首页"+bookPageInfo.isIsFirstPage());
        System.out.println("是否是结尾"+bookPageInfo.isIsLastPage());
        System.out.println("前一页"+bookPageInfo.getPrePage());
        System.out.println("后一页"+bookPageInfo.getNextPage());
        System.out.println("要连续显示的页码"+ Arrays.toString(bookPageInfo.getNavigatepageNums()));
        model.addAttribute("books",bookPageInfo);
        return "success";
    }


}
