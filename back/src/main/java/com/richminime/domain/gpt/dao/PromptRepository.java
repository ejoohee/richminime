package com.richminime.domain.gpt.dao;

import com.richminime.domain.gpt.domain.Prompt;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PromptRepository extends JpaRepository<Prompt, Long> {
    List<Prompt> findByUser_UserId(Long userId);

}
