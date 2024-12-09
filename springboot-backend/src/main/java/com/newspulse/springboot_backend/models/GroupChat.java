package com.newspulse.springboot_backend.models;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Document("group-chat")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class GroupChat {
    @Id
    private String id;
    @Indexed(unique = true)
    @Field("groupName")
    private String groupName;
    private List<UserDetails> members;
    private List<Message> messages;
    private Message lastMessage;
}
