package com.richminime.domain.gpt.dao;

import com.richminime.domain.gpt.domain.Prompt;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PromptRepository extends JpaRepository<Prompt, Long> {


}
