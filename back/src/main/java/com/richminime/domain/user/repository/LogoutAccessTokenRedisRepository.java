package com.richminime.domain.user.repository;

import com.richminime.domain.user.domain.LogOutAccessToken;
import org.springframework.data.repository.CrudRepository;

public interface LogoutAccessTokenRedisRepository extends CrudRepository<LogOutAccessToken, String> {


}
