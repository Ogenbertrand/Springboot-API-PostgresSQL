package com.Spring_API.demo.repository;

import com.Spring_API.demo.domain.Users;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsersRepository extends JpaRepository<Users, Long> {
   Users findByEmail(String apiEmail);
}
