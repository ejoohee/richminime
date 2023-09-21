package com.richminime.domain.bankBook.dao;

import com.richminime.domain.bankBook.domain.BankBook;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BankBookRepository extends JpaRepository<BankBook, Long> {
}
