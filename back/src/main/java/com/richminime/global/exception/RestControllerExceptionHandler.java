package com.richminime.global.exception;

import com.richminime.global.dto.ResponseDto;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import static com.richminime.global.constant.ExceptionMessage.AUTHORIZATION_FAILED;

@RestControllerAdvice(annotations = RestController.class)
public class RestControllerExceptionHandler {
    @ExceptionHandler(DuplicatedException.class)
    public ResponseEntity<ResponseDto<String>> handleDuplicatedException(
            DuplicatedException exception) {
        return ResponseEntity.status(HttpStatus.CONFLICT).body(
                ResponseDto.create(exception.getMessage())
        );
    }

    @ExceptionHandler(TokenException.class)
    public ResponseEntity<ResponseDto<String>> handleTokenException(TokenException exception) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(
                ResponseDto.create(exception.getMessage())
        );
    }

    @ExceptionHandler(NotFoundException.class)
    public ResponseEntity<ResponseDto<String>> handleNotFoundException(
            NotFoundException exception) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                ResponseDto.create(exception.getMessage())
        );
    }

    @ExceptionHandler(IllegalArgumentException.class)
    protected ResponseEntity<ResponseDto<String>> handleIllegalArgumentException(IllegalArgumentException exception) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                ResponseDto.create(exception.getMessage())
        );
    }

    @ExceptionHandler(ForbiddenException.class)
    public ResponseEntity<ResponseDto<String>> handleForbiddenException(
            ForbiddenException exception) {
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(
                ResponseDto.create(AUTHORIZATION_FAILED.getMessage())
        );
    }
}
