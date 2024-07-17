## Spring Boot API with PostgresSQL  Database 👨🏽‍💻🚀🇨🇲
Visit [link](https://www.postgresql.org/docs/current/, 
https://spring.io/guides/gs/spring-boot, https://docs.docker.com/compose/gettingstarted/) to know more...

This repo is going to direct you with the steps on how to create a simple API with;

- Spring boot
- PostgreSQL 
- docker-compose
- gradle

## Development Steps
- Create Spring Boot Application https://start.spring.io/
- Configure PostgreSQL Database
- Connect your Sprinboot Application to your DB
- Create your Entity 
- Create your Repository 
- Create your Service
- Create your Controller
- Test your API with Postman


#### Ensure you follow all the steps below till the end !

### Steps

1) Create your "docker-compose.yaml" file and insert the below code to create your database and container
```
version: '4.1'
services:
  postgres_db:
    image: postgres:latest
    restart: always
    environment:
      - POSTGRES_DB=demo
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=password
    ports:
      - '5435:5432'
    volumes:
      - postgres_db:/var/lib/postgresql/data

volumes:
  postgres_db: { }
```
The docker-compose file will pull the latest version of postgres from https://hub.docker.com/ and then start up a container.

Run this command on your terminal to start your container, add option "-d" to run it in detach mode
```
docker-compsoe up -d
```
⬇️⬇️


2) Connect your created database to your application. Navigate to your resource folder, in your;
application.properties file add
```
spring.datasource.url=jdbc:postgresql://localhost:5432/demo
spring.datasource.username=postgres  ## select the one you want
spring.datasource.password=password  ## select the one you want
spring.jpa.hibernate.ddl-auto=create  ## select the one you want

```
### OR
application.yaml file add
```
spring:
  datasource:
    url: jdbc:postgresql://localhost:5435/demo ## select the one you want
    username: postgres  ## select the one you want                     
    password: password  ## select the one you want
    driver-class-name: org.postgresql.Driver
  jpa:
    hibernate:
      ddl-auto: update
```

⬇️⬇️


3) Create your Entity, Controller, Repository, and Service packages in your "src" folder;

- Entity package add
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
    private Long id; 
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
    private Long id; 
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
- Controller package add
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
- Repository package add 
```
package com.Spring_API.demo.repository;

import com.Spring_API.demo.domain.Users;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsersRepository extends JpaRepository<Users, Long> {
   Users findByEmail(String apiEmail);
}

```

⬇️⬇️
- service package add;
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

⬇️⬇️

4) If you decide to use Spring Security, navigate to your "src" folder and create the class
SecurityConfig.java and add
```
    package com.Spring_API.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests((requests) -> requests
                        .requestMatchers("/**").permitAll()
                )
                .csrf(AbstractHttpConfigurer::disable);
        return http.build();
    }

}

```


The SecurityFilterChain bean defines which URL paths should be secured and which should not. Specifically, the paths are configured to not require any authentication. All other paths must be authenticated.


Have you encountered errors like 😫😮‍💨 ?;
```
FATAL: role "postgres" does not exist  ##user of your database
```
```
Failed to configure a DataSource: 'url' attribute is not specified and no embedded datasource could be configured
```


### Don't bother let me help😁

- The error "postgres user does not exit" occur due to the fact that the port listed in your docker-compose.yaml file is conflicting with the installed version of postgres in your system.
To fix it go the ports section in your docker-compose file change the ports;
e.g
- ```
  ports:
    "5432:5432" to "5433:5432" 
  ```


- The second error message you encounter indicates that spring boot is unable to configure datasource "url" because it could not find the drive class for PostgreSQL. To fix just make sure you use application.yml file to connect to your database don't change the name.

### If you wish to clone the repo directly !,

-  clone the repo with the command 
```
git clone git@github.com:Ogenbertrand/Springboot-API-PostgresSQL.git
```

- cd into the cloned folder 
```angular2html
cd Springboot-API-PostgresSQL
```
- You can run the application by using 
```
./gradlew bootRun
```
- Alternatively, you can build the JAR file by using "./gradlew build" and then run the JAR file, as follows:

## Congratulation you just created your first API !🥳
