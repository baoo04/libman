// interfaces/UserDAO.java
package com.libman.dao.interfaces;

import com.libman.model.User;
import java.util.Set;

public interface UserDAO {
    User findByUsername(String username);

    Set<String> findRoles(Long userId);
}