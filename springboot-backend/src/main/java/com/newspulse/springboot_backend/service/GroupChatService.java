package com.newspulse.springboot_backend.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.newspulse.springboot_backend.models.GroupChat;
import com.newspulse.springboot_backend.models.Message;
import com.newspulse.springboot_backend.models.UserDetails;
import com.newspulse.springboot_backend.repository.GroupChatRepository;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class GroupChatService {
    final GroupChatRepository groupChatRepository;

    public GroupChatService(GroupChatRepository groupChatRepository) {
        this.groupChatRepository = groupChatRepository;
    }

    public void createGroupChat(GroupChat groupChat) {
        if (groupChatRepository.findByGroupName(groupChat.getGroupName()) == null) {
            groupChatRepository.save(groupChat);
        } else {
            throw new IllegalArgumentException("Group chat already exists");
        }
    }

    public List<Message> getMessages(String groupName) {
        GroupChat groupChat = groupChatRepository.findByGroupName(groupName);
        return groupChat.getMessages();
    }

    public void addNewMember(String groupName, UserDetails user) {
        try {
            GroupChat groupChat = groupChatRepository.findByGroupName(groupName);
            groupChat.getMembers().add(user);
            user.getGroupList().add(groupName);
        } catch (Exception e) {
            throw new IllegalArgumentException("Group chat does not exist");
        }
    }

    public List<GroupChat> getGroupsForUser(String username) {
        try{
            List<GroupChat> allGroups = groupChatRepository.findAll();

        List<GroupChat> userGroups = allGroups.stream()
                .filter(group -> group.getMembers().stream().anyMatch(member -> member.getUsername().equals(username)))
                .collect(Collectors.toList());
        log.info("In service, user is part of the following groups: " + userGroups);
        return userGroups;
        } catch (Exception e) {
            log.error("In service, User isnt part of any Group");
            throw new IllegalArgumentException("User isnt part of any Group");
        }

    }
}
