package com.newspulse.springboot_backend.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.kafka.common.serialization.Deserializer;
import com.newspulse.springboot_backend.models.ChatMessage;

public class ChatMessageDeserializer implements Deserializer<ChatMessage> {

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public ChatMessage deserialize(String topic, byte[] data) {
        try {
            return objectMapper.readValue(data, ChatMessage.class);  // Convert byte array back to object
        } catch (Exception e) {
            throw new RuntimeException("Error deserializing ChatMessage", e);
        }
    }
}

