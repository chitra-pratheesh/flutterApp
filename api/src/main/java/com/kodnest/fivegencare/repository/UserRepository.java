package com.kodnest.fivegencare.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kodnest.fivegencare.model.User;

public interface UserRepository extends JpaRepository<User,Integer> {
    User findByEmailAndPassword(String email,String password);
}
