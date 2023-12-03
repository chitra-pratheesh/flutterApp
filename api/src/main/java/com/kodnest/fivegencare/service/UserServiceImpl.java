package com.kodnest.fivegencare.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kodnest.fivegencare.model.User;
import com.kodnest.fivegencare.repository.UserRepository;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
    private UserRepository userRepository;	
	
	@Override
	public User register(User user) {
        return userRepository.save(user);
    }	
	@Override
	public User findByEmailAndPassword(String email,String password) {
		User oldUSer = userRepository.findByEmailAndPassword(email, password);
        if(oldUSer == null) {
        	User user= new User();
        	user.setEmail(email);
        	user.setPassword(password);
        	oldUSer = userRepository.save(user);
        }
        return oldUSer;
	}
}
