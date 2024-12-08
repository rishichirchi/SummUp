package com.newspulse.springboot_backend.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

import com.newspulse.springboot_backend.models.UserDetails;

@Repository
public interface UserDetailsRepository extends MongoRepository<UserDetails, String>{
    
    @Query("{'username': ?0}")
    UserDetails findByUsername(String username);
}
