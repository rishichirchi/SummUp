package com.newspulse.springboot_backend.config;

import org.apache.kafka.common.serialization.Serializer;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.newspulse.springboot_backend.models.ChatMessage;
import java.util.Map;

public class ChatMessageSerializer implements Serializer<ChatMessage> {

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void configure(Map<String, ?> configs, boolean isKey) {
    }

    @Override
    public byte[] serialize(String topic, ChatMessage data) {
        try {
            return objectMapper.writeValueAsBytes(data);  // Convert object to JSON (byte array)
        } catch (Exception e) {
            throw new RuntimeException("Error serializing ChatMessage", e);
        }
    }

    @Override
    public void close() {
    }
}
