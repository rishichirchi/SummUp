package com.newspulse.springboot_backend.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.newspulse.springboot_backend.models.GroupChat;
import com.newspulse.springboot_backend.models.Message;
import com.newspulse.springboot_backend.models.UserDetails;
import com.newspulse.springboot_backend.service.GroupChatService;

import lombok.extern.slf4j.Slf4j;


@RestController
@Slf4j
public class GroupChatController {
    final GroupChatService groupChatService;

    public GroupChatController(GroupChatService groupChatService) {
        this.groupChatService = groupChatService;
    }

    @PostMapping("/createGroupChat")
    public ResponseEntity<?> createGroupChat(@RequestBody GroupChat groupChat) {
        try {
            groupChatService.createGroupChat(groupChat);
            Map<String, String> response = new HashMap<>();
            response.put("message", "Group chat created successfully");
            log.info(response.get("message"));
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (IllegalArgumentException e) {
            log.error(e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping("/getMessages/{groupName}")
    public ResponseEntity<List<Message>> getAllMessages(@PathVariable String groupName) {
        return ResponseEntity.status(HttpStatus.OK).body(groupChatService.getMessages(groupName));
    }

    @PostMapping("/addMember/{groupName}")
    public ResponseEntity<?> addMember(@PathVariable String groupName, @RequestBody UserDetails user) {
        try {
            groupChatService.addNewMember(groupName, user);
            Map<String, String> response = new HashMap<>();
            response.put("message", "User added successfully");
            return ResponseEntity.status(HttpStatus.OK).body(response);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping("/getGroupsForUser/{username}")
    public ResponseEntity<?> getSpecifcGroups(@PathVariable String username) {
        log.info("Getting groups for user: " + username);
       try{
        List<GroupChat> groups = groupChatService.getGroupsForUser(username);
       Map<String, Object> response = new HashMap<>();
        response.put("username", username);
         response.put("groups", groups);

         log.info("Groups for user: " + username + " are: " + groups);

        return ResponseEntity.status(HttpStatus.OK).body(response);
       }
       catch(IllegalArgumentException e){
            log.error("User isnt part of any Group");
           return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
       }

    }
    
}
