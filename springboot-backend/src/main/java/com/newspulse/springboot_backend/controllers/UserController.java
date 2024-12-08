package com.newspulse.springboot_backend.controllers;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.newspulse.springboot_backend.models.UserDetails;
import com.newspulse.springboot_backend.service.UserServices;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;



@Controller
@RequestMapping("/user")
public class UserController {
    private final UserServices userServices;

    public UserController(UserServices userServices){
        this.userServices = userServices;
    }

    @PostMapping("/register")
    public ResponseEntity<String> createNewUser(@RequestBody UserDetails user) {
        try{
            userServices.createUser(user);
            return ResponseEntity.status(HttpStatus.CREATED).body("User created successfully");
        }
        catch(IllegalArgumentException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @PostMapping("/login/{username}")
    public ResponseEntity<String> loginUser(@PathVariable String username){
        try{
            userServices.loginUser(username);
            return ResponseEntity.status(HttpStatus.OK).body("User logged in successfully");
        }
        catch(IllegalArgumentException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @PostMapping("/logout/{username}")
    public ResponseEntity<String> logoutUser(@PathVariable String username){
        try{
            userServices.logoutUser(username);
            return ResponseEntity.status(HttpStatus.OK).body("User logged out successfully");
        }
        catch(IllegalArgumentException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @PostMapping("/delete/{username}")
    public ResponseEntity<String> deleteUser(@PathVariable String username){
        try{
            userServices.deleteUser(username);
            return ResponseEntity.status(HttpStatus.OK).body("User deleted successfully");
        }
        catch(IllegalArgumentException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping("/users")
    public ResponseEntity<List<UserDetails>> getAllUsers() {
        return ResponseEntity.status(HttpStatus.OK).body(userServices.getAllUsers());
    }

    @GetMapping("/get-user/{username}")
    public ResponseEntity<UserDetails> getUser(@PathVariable String username){
        UserDetails user = userServices.getUser(username);
        if(user == null){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return ResponseEntity.status(HttpStatus.OK).body(user);
    }
    
    
}
