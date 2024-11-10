package com.newspulse.springboot_backend.service;

import org.springframework.stereotype.Service;

import com.newspulse.springboot_backend.models.ChatMessage;

import lombok.extern.slf4j.Slf4j;

import org.springframework.kafka.core.KafkaTemplate;

@Service
@Slf4j
public class KafkaProducerServices {
    private static final String TOPIC = "public-chats";
    private final KafkaTemplate<String, ChatMessage> kafkaTemplate;

    public KafkaProducerServices(KafkaTemplate<String, ChatMessage> kafkaTemplate){
        this.kafkaTemplate = kafkaTemplate;
    }

    public void sendMessage(ChatMessage message){
        log.info("Producing message: {}", message);
        kafkaTemplate.send(TOPIC, message);
    }
}
