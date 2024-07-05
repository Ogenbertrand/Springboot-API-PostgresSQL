## Spring Boot API with PostgresSQL  Database 👨🏽‍💻🚀🇨🇲
Visit link to know more about the tools [link](https://www.postgresql.org/docs/current/
https://spring.io/guides/gs/spring-boot)

This repo is going to direct you with the steps on how to create a simple API with;

- Spring boot
- PostgreSQL 
- docker-compose
- gradle

#### Ensure you follow all the steps below till the end !

### Steps

1) Create your "docker-compose.yaml" file and insert the below code to create your database and container
```
version: '3.8'
services:
  postgres_db:
    image: postgres:latest
    container_name: API-container
    restart: always
    environment:
      - POSTGRES_DB=postgres  ##select the one you want
      - POSTGRES_USER=postgres  ##select the one you want
      - POSTGRES_PASSWORD=password  ##select the one you want
    ports:
      - '5432:5432'
    volumes:
      - postgres_db:/var/lib/postgresql/data
volumes:
  postgres_db:
    driver: local
```
Run this command on your terminal to start your container, add option "-d" to run it in detach mode
```
docker-compsoe up -d
```
⬇️⬇️
2) Connect your created database to your application. Navigate to your resource folder, in your;
application.properties file add
```
spring.datasource.url=jdbc:postgresql://localhost:5432/postgres
spring.datasource.username=postgres  ##select the one you want
spring.datasource.password=password  ##select the one you want
spring.jpa.hibernate.ddl-auto=create  ##select the one you want

```
### OR
application.yaml file add
```
spring:
  datasource:
    driver-class-name: org.postgresql.Driver
    url: jdbc:postgresql://localhost:5434/postgres  ##select the one you want
    username: postgres  ##select the one you want
    password: password  ##select the one you want

  jpa:
    hibernate:
      ddl-auto: create
```

⬇️⬇️
3) If you decide to use Spring Security, navigate to your "src" folder and create the file 
SecurityConfig.java and add
```
    @Bean
    public SecurityFilterChain springSecurityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(authorize -> authorize
                        .anyRequest().authenticated()
                )
                .formLogin(Customizer.withDefaults())
                .httpBasic(Customizer.withDefaults());
        return http.build();
    }

```

⬇️⬇️
4) Create your Entity, Controller, Repository, and Service class in your "src" folder;

- Entity class add
```
package com.Spring_API.demo.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "Users")
public class Users {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // Changed to Long, as it's a more common type for IDs
    private String username;
    private String email;
    private String password;

    public Users() {}

    public Users(String username, String email, String password) {
        this.username = username;
        this.email = email;
        this.password = password;
    }
}
 @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // Changed to Long, as it's a more common type for IDs
    private String username;
    private String email;
    private String password;

    public Users() {}

    public Users(String username, String email, String password) {
        this.username = username;
        this.email = email;
        this.password = password;
    }
```


⬇️⬇️
- Controller class add
```
package com.Spring_API.demo.controller;

import com.Spring_API.demo.domain.Users;
import com.Spring_API.demo.service.UsersService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
@RequiredArgsConstructor
public class UsersController {

    private final UsersService usersService;

    @GetMapping("/get")
    public ResponseEntity<List<Users>> getAllUsers() {
        List<Users> users = usersService.getAllUsers();
        return new ResponseEntity<>(users, HttpStatus.OK);
    }

    @PostMapping
    public ResponseEntity<Users> createUser(@Validated @RequestBody Users user) {
        Users savedUser = usersService.saveUser(user);
        return new ResponseEntity<>(savedUser, HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Users> deleteUser(@PathVariable Long id) {
        usersService.deleteUserById(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}

```

⬇️⬇️
- Repository class add 
```
package com.Spring_API.demo.repository;

import com.Spring_API.demo.domain.Users;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsersRepository extends JpaRepository<Users, Long> {
   Users findByEmail(String apiEmail);
}

```

⬇️⬇️
- service class add;
```
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

```






Have you encountered errors like 😫😮‍💨 ?;
```
FATAL: role "postgres" does not exist  ##user of your database
```
```
Failed to configure a DataSource: 'url' attribute is not specified and no embedded datasource could be configured
```
```
 Unsatisfied dependency expressed through constructor parameter 0: Could not convert argument value of type [java.util.ArrayList] to required type [java.util.List]: Failed to convert value of type 'java.util.ArrayList' to required type 'java.util.List'; Cannot convert value of type 'org.springframework.security.web.DefaultSecurityFilterChain' to required type 'jakarta.servlet.Filter': no matching editors or conversion strategy found
```

### Don't bother 😁

- The error "postgres user does not exit" occur due to the fact that the port listed in your docker-compose.yaml file is conflicting with the installed version of postgres in your system.
To fix it go the ports section in your docker-compose file change the ports;
e.g
- ```
  ports:
    "5432:5432" to "5433:5432" 
  ```



- The second error message you encounter indicates that spring boot is unable to configure datasource "url" because it could not find the drive class for PostgreSQL. To fix just make you connecting database in an application.yml file don't change the name.



- The third error message you're encountering suggests that Spring Security is expecting a List of filters (jakarta.servlet.Filter) for the springSecurityFilterChain, but it's receiving an ArrayList instead, which it cannot convert.



## Follow all the above steps carefully and Thank me later!🥳
