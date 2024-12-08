package com.newspulse.springboot_backend.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newspulse.springboot_backend.models.UserDetails;
import com.newspulse.springboot_backend.repository.UserDetailsRepository;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class UserServices {
    private final UserDetailsRepository userDetailsRepository;

    public UserServices(UserDetailsRepository userDetailsRepository){
        this.userDetailsRepository = userDetailsRepository;
    }

    public void createUser(UserDetails user){
        if(userDetailsRepository.findByUsername(user.getUsername()) == null){
            userDetailsRepository.save(user);

        }
        throw new IllegalArgumentException("User already exists");


    }

    public UserDetails getUser(String username){
        return userDetailsRepository.findByUsername(username);
    }

    public void logoutUser(String username){
        UserDetails user = userDetailsRepository.findByUsername(username);
        if(user == null){
            throw new IllegalArgumentException("User does not exist");
        }

        user.setLoggedIn(false);
        userDetailsRepository.save(user);
    }

    public void loginUser(String username){
        UserDetails user = userDetailsRepository.findByUsername(username);
        if(user == null){
            log.error("User does not exist");
            throw new IllegalArgumentException("User does not exist");
        }

        user.setLoggedIn(true);
        userDetailsRepository.save(user);
    }

    public void deleteUser(String username){
        UserDetails user = userDetailsRepository.findByUsername(username);
        if(user == null){
            throw new IllegalArgumentException("User does not exist");
        }

        userDetailsRepository.delete(user);
    }

    public List<UserDetails> getAllUsers(){
        return userDetailsRepository.findAll();
    }
}
