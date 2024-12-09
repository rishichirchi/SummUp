package com.newspulse.springboot_backend.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.web.bind.annotation.RequestBody;

import com.newspulse.springboot_backend.models.GroupChat;
import com.newspulse.springboot_backend.models.Message;
import com.newspulse.springboot_backend.models.UserDetails;
import com.newspulse.springboot_backend.service.MessagingService;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PostMapping;



@RestController
@Slf4j
public class MessagingController {
    private final MessagingService  messagingService;

    public MessagingController(MessagingService messagingService){
        this.messagingService = messagingService;
    }

    @MessageMapping("/chat/{groupName}/send-message")
    @SendTo("/chat/{groupName}")
    public ResponseEntity<?> handleMessage(@RequestBody Message message){
        try{
            messagingService.sendMessage(message);
            Map<String, String> response = new HashMap<>();
            response.put("message", "Message sent successfully");
            return ResponseEntity.status(HttpStatus.OK).body(response);
        }
        catch(IllegalArgumentException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping("/getMessages/{groupName}")
    public ResponseEntity<List<Message>> getAllMessages(@PathVariable String groupName) {
        return ResponseEntity.status(HttpStatus.OK).body(messagingService.getMessages(groupName));
    }

    @PostMapping("/createGroupChat")
    public ResponseEntity<?> createGroupChat(@RequestBody GroupChat groupChat) {
        try {
            messagingService.createGroupChat(groupChat);
            Map<String, String> response = new HashMap<>();
            response.put("message", "Group chat created successfully");
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @PostMapping("/addMember/{groupName}")
    public ResponseEntity<?> addMember(@PathVariable String groupName, @RequestBody UserDetails user) {
        try {
            messagingService.addNewMember(groupName, user);
            Map<String, String> response = new HashMap<>();
            response.put("message", "User added successfully");
            return ResponseEntity.status(HttpStatus.OK).body(response);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }
    


    
}
