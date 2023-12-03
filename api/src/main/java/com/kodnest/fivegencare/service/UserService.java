package com.kodnest.fivegencare.service;

import com.kodnest.fivegencare.model.User;

public interface UserService {

	User register(User user);

	User findByEmailAndPassword(String email, String password);

}