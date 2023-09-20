package com.richminime.domain.user.repository;

import com.richminime.domain.user.domain.RefreshToken;
import org.springframework.data.repository.CrudRepository;


public interface RefreshTokenRedisRepository extends CrudRepository<RefreshToken, String> {



}
