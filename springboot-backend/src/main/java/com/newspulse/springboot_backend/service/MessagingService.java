package com.newspulse.springboot_backend.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.newspulse.springboot_backend.models.GroupChat;
import com.newspulse.springboot_backend.models.Message;
import com.newspulse.springboot_backend.models.UserDetails;
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
        } catch (Exception e) {
            throw new IllegalArgumentException("Group chat does not exist");
        }
    }

    public List<Message> getMessages(String groupName) {
        GroupChat groupChat = groupChatRepository.findByGroupName(groupName);
        return groupChat.getMessages();
    }

    public void createGroupChat(GroupChat groupChat) {
        if (groupChatRepository.findByGroupName(groupChat.getGroupName()) == null) {
            groupChatRepository.save(groupChat);
        }
        throw new IllegalArgumentException("Group chat already exists");
    }

    public void addNewMember(String groupName, UserDetails user){
        try{
            GroupChat groupChat = groupChatRepository.findByGroupName(groupName);
            groupChat.getMembers().add(user);
            user.getGroupList().add(groupName);
        }
        catch(Exception e){
            throw new IllegalArgumentException("Group chat does not exist");
        }
    }

}
