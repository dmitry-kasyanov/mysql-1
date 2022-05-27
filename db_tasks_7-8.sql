/*
Задача 7. Представление 1. Вывести список немецких слов с переводом на английский язык. 
*/

USE lingvo;
CREATE OR REPLACE VIEW v_german_english AS
SELECT ge.word AS "Немецкий", en.word AS "Английский" FROM german ge JOIN english en ON ge.russian_code = en.russian_code;

/*
Задача 7. Представление 2. Вывести список пользователей, которые добавили свои варианты перевода слов. 
*/

USE lingvo;
CREATE OR REPLACE VIEW v_active_translators AS
SELECT u.firstname AS First_Name, u.lastname AS Last_Name, COUNT(tr.user_id) AS Quantity FROM users u JOIN translations tr ON u.id = tr.user_id GROUP BY tr.user_id ORDER BY Quantity DESC;


/*
Задача 8. Хранимая процедура 1. Для пользователя, который сохраняет для повторения слова заданного языка (language_code = 5), подобрать друзей из числа пользователей, которые тоже сохраняют для повторения слова этого языка.
*/

USE lingvo;

DROP PROCEDURE IF EXISTS sp_friendship_offers;

DELIMITER //

CREATE PROCEDURE sp_friendship_offers(IN for_user_id BIGINT)
BEGIN
SELECT DISTINCT wtl2.user_id
FROM words_to_learn wtl1
JOIN words_to_learn wtl2 ON wtl1.language_code = wtl2.language_code
WHERE wtl2.language_code = '5' AND wtl1.user_id = for_user_id AND wtl2.user_id <> for_user_id
ORDER BY RAND();	
END//

DELIMITER ;

CALL sp_friendship_offers(10);

/*
Задача 8. Хранимая процедура 2. Для пользователя, который добавляет свои варианты перевода слов заданного языка (language_code = 3), подобрать учеников из числа пользователей, которые сохраняют для повторения слова этого языка.
*/

USE lingvo;

DROP PROCEDURE IF EXISTS sp_students_for_teacher;

DELIMITER //

CREATE PROCEDURE sp_students_for_teacher(IN for_user_id BIGINT)
BEGIN
SELECT DISTINCT wtl.user_id
FROM words_to_learn wtl
JOIN translations tr ON tr.language_code = wtl.language_code
WHERE wtl.language_code = '3' AND tr.user_id = for_user_id AND wtl.user_id <> for_user_id
ORDER BY RAND();	
END//

DELIMITER ;

CALL sp_students_for_teacher(2);


/*
Задача 8. Триггер 1. Проверка значения поля created_at перед вставкой новой записи в таблицу words_to_learn.
*/

USE lingvo;
DELIMITER //
CREATE TRIGGER validate_date_before_insert BEFORE INSERT ON words_to_learn
FOR EACH ROW
BEGIN
IF NEW.created_at > CURRENT_TIMESTAMP THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Неправильно указаны дата и время.';
END IF;
END//
DELIMITER ;

/*
Задача 8. Триггер 2. Исправление значения поля updated_at при обновлении записи в таблице words_to_learn.
*/

USE lingvo;
DELIMITER //
CREATE TRIGGER validate_date_before_update BEFORE UPDATE ON words_to_learn
FOR EACH ROW
BEGIN
IF NEW.updated_at > CURRENT_TIMESTAMP THEN
SET NEW.updated_at = CURRENT_TIMESTAMP;
END IF;
END//
DELIMITER ;