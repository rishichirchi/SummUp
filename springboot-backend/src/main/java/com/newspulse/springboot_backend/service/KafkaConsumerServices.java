package com.newspulse.springboot_backend.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.newspulse.springboot_backend.models.ChatMessage;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class KafkaConsumerServices {
    private static final String TOPIC = "public-chats";
    private final SimpMessagingTemplate simpMessagingTemplate;
    private final List<ChatMessage> chatMessages = new ArrayList<>();

    public KafkaConsumerServices(SimpMessagingTemplate simpMessagingTemplate){
        this.simpMessagingTemplate = simpMessagingTemplate;
    }

    @KafkaListener(topics = TOPIC, groupId = "moodpulse-consumer")
    public void handleMessage(ChatMessage message){
        log.info("Received message: {}", message);
        chatMessages.add(message);
        simpMessagingTemplate.convertAndSend("/chat/public", message);
    }

    public List<ChatMessage> getChatMessages(){
        return new ArrayList<>(chatMessages);
    }

    
}
