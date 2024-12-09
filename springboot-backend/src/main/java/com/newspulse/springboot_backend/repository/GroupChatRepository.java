package com.newspulse.springboot_backend.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

import com.newspulse.springboot_backend.models.GroupChat;

@Repository
public interface GroupChatRepository extends MongoRepository<GroupChat, String> {
    
    @Query("{'groupName': ?0}")
    GroupChat findByGroupName(String groupName);
}
