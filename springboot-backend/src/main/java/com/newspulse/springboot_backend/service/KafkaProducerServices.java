package com.newspulse.springboot_backend.service;

import org.springframework.stereotype.Service;

import com.newspulse.springboot_backend.models.ChatMessage;

import org.springframework.kafka.core.KafkaTemplate;

@Service
public class KafkaProducerServices {
    private static final String TOPIC = "public-chats";
    private final KafkaTemplate<String, ChatMessage> kafkaTemplate;

    public KafkaProducerServices(KafkaTemplate<String, ChatMessage> kafkaTemplate){
        this.kafkaTemplate = kafkaTemplate;
    }

    public void sendMessage(ChatMessage message){
        kafkaTemplate.send(TOPIC, message);
    }
}
