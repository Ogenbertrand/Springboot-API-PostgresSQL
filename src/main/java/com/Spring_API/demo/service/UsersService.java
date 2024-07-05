package com.Spring_API.demo.service;

import com.Spring_API.demo.domain.Users;
import com.Spring_API.demo.repository.UsersRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UsersService {

    private final UsersRepository apiRepository;
    private final UsersRepository usersRepository;

    public List<Users> getAllUsers() {
        return apiRepository.findAll();
    }

    public Users saveUser(Users user) {
        return apiRepository.save(user);
    }

    public Users getByUsername(String email) {
        return apiRepository.findByEmail(email);
    }

    public void deleteUserById(Long id) {
        usersRepository.deleteById(id);
    }
}
