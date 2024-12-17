package com.newspulse.springboot_backend.service;


import org.springframework.stereotype.Service;

import com.newspulse.springboot_backend.models.GroupChat;
import com.newspulse.springboot_backend.models.Message;
import com.newspulse.springboot_backend.repository.GroupChatRepository;

@Service
public class MessagingService {
    private final GroupChatRepository groupChatRepository;

    public MessagingService(GroupChatRepository groupChatRepository) {
        this.groupChatRepository = groupChatRepository;
    }

    public void sendMessage(Message message) {
        try {
            GroupChat groupChat = groupChatRepository.findByGroupName(message.getGroupName());
            groupChat.getMessages().add(message);
            groupChatRepository.save(groupChat);
        } catch (Exception e) {
            throw new IllegalArgumentException("Group chat does not exist");
        }
    }

}
