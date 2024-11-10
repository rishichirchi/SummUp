package com.newspulse.springboot_backend.controllers;

import java.util.List;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.web.bind.annotation.RestController;

import com.newspulse.springboot_backend.models.ChatMessage;
import com.newspulse.springboot_backend.service.KafkaConsumerServices;
import com.newspulse.springboot_backend.service.KafkaProducerServices;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;


@RestController
@Slf4j
public class WebSocketController {
    private final KafkaProducerServices kafkaProducerServices;
    private final KafkaConsumerServices kafkaConsumerServices;

    public WebSocketController(KafkaProducerServices kafkaProducerServices, KafkaConsumerServices kafkaConsumerServices){
        this.kafkaProducerServices = kafkaProducerServices;
        this.kafkaConsumerServices = kafkaConsumerServices;
    }

    @MessageMapping("/chat.sendMessage")
    @SendTo("/chat/public")
    public void handleMessage(@Payload ChatMessage message){
        kafkaProducerServices.sendMessage(message);
    }

    @GetMapping("/getChats")
    public List<ChatMessage> getChatMessages() {
        return kafkaConsumerServices.getChatMessages();
    }
    

    @MessageMapping("/chat.addUser")
    @SendTo("/chat/public")
    public void addUser(@Payload ChatMessage message, SimpMessageHeaderAccessor headerAccessor){
        log.info("User added: {}", message.getSender());

        if(headerAccessor != null && headerAccessor.getSessionAttributes() != null){
            log.info("Session attributes: {}", headerAccessor.getSessionAttributes());
        }
        else{
            log.error("Header accessor is null or session attributes are null");
        }

        kafkaProducerServices.sendMessage(message);
    }

    @MessageMapping("/chat.removeUser")
    @SendTo("/chat/public")
    public void removeUser(@Payload ChatMessage message, SimpMessageHeaderAccessor headerAccessor){
        log.info("User removed: {}", message.getSender());

        if(headerAccessor != null && headerAccessor.getSessionAttributes() != null){
            headerAccessor.getSessionAttributes().remove("username");
        }
        else{
            log.error("Header accessor is null or session attributes are null");
        }
    }
}
