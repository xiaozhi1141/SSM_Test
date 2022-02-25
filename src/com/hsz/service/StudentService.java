package com.hsz.service;

import com.hsz.bean.Student;
import com.hsz.dao.StudentDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentService {
    @Autowired
    private StudentDao studentDao;
    public Student getStudent(Integer id){
        return studentDao.getStudentById(id);
    }
}
