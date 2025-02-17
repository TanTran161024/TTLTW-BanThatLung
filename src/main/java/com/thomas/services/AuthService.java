package com.thomas.services;

import com.thomas.dao.UserDao;
import com.thomas.dao.model.User;

public class AuthService {
    public User checkLogin(String email, String password) {
        UserDao udao = new UserDao();
        User u = udao.findUserEmail(email);
        if (u != null && password != null && u.getIsActive() == 1 && u.getIsDeleted() == 0) {
            if (MD5Service.hashPassword(password).equals(u.getPassword())) {
                u.setPassword(null);
                return u;
            }
        }

        return null;
    }

}
