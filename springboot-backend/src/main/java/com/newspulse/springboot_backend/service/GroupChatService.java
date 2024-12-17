package com.newspulse.springboot_backend.service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.swing.GroupLayout.Group;

import org.springframework.stereotype.Service;

import com.newspulse.springboot_backend.models.GroupChat;
import com.newspulse.springboot_backend.models.Message;
import com.newspulse.springboot_backend.models.UserDetails;
import com.newspulse.springboot_backend.repository.GroupChatRepository;
import com.newspulse.springboot_backend.repository.UserDetailsRepository;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class GroupChatService {
    final GroupChatRepository groupChatRepository;
    final UserDetailsRepository userDetailsRepository;

    public GroupChatService(GroupChatRepository groupChatRepository, UserDetailsRepository userDetailsRepository) {
        this.groupChatRepository = groupChatRepository;
        this.userDetailsRepository = userDetailsRepository;
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
        log.info("Here is the GroupChat that you want to get messages from"+groupChat);
        return groupChat.getMessages();
    }

    public void addNewMember(String groupName, String username) {
        try {
            GroupChat groupChat = groupChatRepository.findByGroupName(groupName);
            UserDetails user = userDetailsRepository.findByUsername(username);
            groupChat.getMembers().add(user);
            groupChatRepository.save(groupChat);
            user.getGroupList().add(groupName);
            userDetailsRepository.save(user);
        } catch (Exception e) {
            throw new IllegalArgumentException("Group chat does not exist");
        }
    }

    public List<GroupChat> getGroupsForUser(String username) {
        try{
            List<GroupChat> allGroups = groupChatRepository.findAll();
            List<GroupChat> userGroups = new ArrayList<GroupChat>();

            for (GroupChat group : allGroups) {
                log.info("Checking group: " + group.getGroupName());
                for (UserDetails user : group.getMembers()) {
                    log.info("Checking member: " + user.getUsername());
                    if (user.getUsername() != null && user.getUsername().trim().equals(username.trim())) {
                        log.info("User matched: " + user.getUsername());
                        userGroups.add(group);
                        break;
                    }
                }
            }
            
        log.info("In service, user is part of the following groups: " + userGroups);
        return userGroups;
        } catch (Exception e) {
            log.error("In service, User isnt part of any Group");
            throw new IllegalArgumentException("User isnt part of any Group");
        }

    }
}
