package com.java.web_ecommerce_spring.serviceImpls;

import com.java.web_ecommerce_spring.domain.AuthenticationProvider;
import com.java.web_ecommerce_spring.domain.User;
import com.java.web_ecommerce_spring.repositorys.UserRepository;
import com.java.web_ecommerce_spring.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserRepository userRepository;

    @Override
    public User save(User user) {
        return userRepository.save(user);
    }

    @Override
    public User findUserById(int id) {
        return userRepository.findUserById(id);
    }

    @Override
    public User findUserByEmail(String email) {
        return userRepository.findUserByEmail(email);
    }

    @Override
    public User findUserByEmailAndPassword(String email, String password) {
        return userRepository.findUserByEmailAndPassword(email,password);
    }

    @Override
    public int delete(int id) {
        return userRepository.delete(id);
    }

    @Override
    public int update(String email , String fullname, String phonenumber, String username, int id) {
        return userRepository.update(email,fullname,phonenumber,username,id);
    }

    @Override
    public List<User> listEmployee() {
        return userRepository.listEmployee();
    }

    @Override
    public List<User> listCustomer() {
        return userRepository.listCustomer();
    }


    //Fb GG login
    public void processOAuthPostLogin(String email, String name, AuthenticationProvider authenticationProvider) {
        Optional<User> user = Optional.ofNullable(userRepository.findUserByEmail(email));
        if(user.isEmpty()){
            User u = new User();
            u.setUserName(email);
            u.setEmail(email);
            u.setFullName(name);
            u.setAuthProvider(authenticationProvider);
            u.setEnable(1);
            userRepository.save(u);
        }
    }
}
