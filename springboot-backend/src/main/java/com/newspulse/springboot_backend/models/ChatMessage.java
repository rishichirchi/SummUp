package com.newspulse.springboot_backend.models;

import org.apache.kafka.shaded.com.google.protobuf.Extension.MessageType;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ChatMessage {
    private String sender;
    private String content;
    private MessageType type;
}
