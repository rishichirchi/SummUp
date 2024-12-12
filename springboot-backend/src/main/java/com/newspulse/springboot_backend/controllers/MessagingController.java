package com.newspulse.springboot_backend.controllers;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.web.bind.annotation.RequestBody;

import com.newspulse.springboot_backend.models.Message;
import com.newspulse.springboot_backend.service.MessagingService;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RestController;



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
}
