package com.kodnest.fivegencare.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.kodnest.fivegencare.model.User;
import com.kodnest.fivegencare.service.UserService;

@RestController

public class UserController {

    @Autowired
    private UserService userService;

    @CrossOrigin
    @PostMapping("/register")
    public User register(@RequestBody User user) {
        return userService.register(user);
    }
    
    @CrossOrigin
    @PostMapping("/login")
    public User Login(@RequestBody User user) {        
        return userService.findByEmailAndPassword(user.getEmail(), user.getPassword());
    }
}
