/*
Проектирование реляционной базы данных для сервиса ABBYY Lingvo Live (www.lingvolive.com).
*/

DROP DATABASE IF EXISTS lingvo;
CREATE DATABASE lingvo;
USE lingvo;

DROP TABLE IF EXISTS languages;
CREATE TABLE languages (
id SERIAL,
language VARCHAR(20),
language_code INT UNSIGNED PRIMARY KEY,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
INDEX languages_idx(language),
INDEX language_codes_idx(language_code)
);

INSERT INTO languages (language, language_code) 
VALUES
('русский', '1'),
('английский', '2'),
('немецкий', '3'),
('французский', '4'),
('китайский', '5');

-- Русский язык.

DROP TABLE IF EXISTS russian;
CREATE TABLE russian (
id SERIAL,
word VARCHAR(100) PRIMARY KEY,
russian_code INT UNSIGNED COMMENT 'Перевод с одного иностранного языка на другой иностранный язык идет через русский язык по коду слова. Код может быть произвольным. Это не значение слова.',
transcription VARCHAR(100) DEFAULT NULL,
audio VARCHAR(100) DEFAULT NULL COMMENT 'Аудиозапись слова.',
language_code INT UNSIGNED DEFAULT '1',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
INDEX russian_word_idx(word),
INDEX russian_code_idx(russian_code),
FOREIGN KEY (language_code) REFERENCES languages(language_code) ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO russian (word, russian_code, audio) 
VALUES
('один', '1', '1234560.wav'),
('два', '2', '2234560.wav'),
('три', '3', '3234560.wav'),
('четыре', '4', '4234560.wav'),
('пять', '5', '5234560.wav'),
('шесть', '6', '6234560.wav'),
('семь', '7', '7234560.wav'),
('восемь', '8', '8234560.wav'),
('девять', '9', '9234560.wav'),
('десять', '10', '1034560.wav');

-- Английский язык.

DROP TABLE IF EXISTS english;
CREATE TABLE english (
id SERIAL,
word VARCHAR(100) PRIMARY KEY,
russian_code INT UNSIGNED,
transcription VARCHAR(100) DEFAULT NULL,
audio VARCHAR(100) DEFAULT NULL,
language_code INT UNSIGNED DEFAULT '2',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
INDEX english_word_idx(word),
FOREIGN KEY (russian_code) REFERENCES russian(russian_code) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (language_code) REFERENCES languages(language_code) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO english (word, russian_code, transcription, audio) 
VALUES
('one', '1', 'wʌn', '1234567.wav'),
('two', '2', 'tuː', '2234567.wav'),
('three', '3', 'θriː', '3234567.wav'),
('four', '4', 'fɔː', '4234567.wav'),
('five', '5', 'faɪv', '5234567.wav'),
('six', '6', 'sɪks', '6234567.wav'),
('seven', '7', 'sev(ə)n', '7234567.wav'),
('eight', '8', 'eɪt', '8234567.wav'),
('nine', '9', 'naɪn', '9234567.wav'),
('ten', '10', 'ten', '1034567.wav');

-- Немецкий язык.

DROP TABLE IF EXISTS german;
CREATE TABLE german (
id SERIAL,
word VARCHAR(100) PRIMARY KEY,
russian_code INT UNSIGNED,
transcription VARCHAR(100) DEFAULT NULL,
audio VARCHAR(100) DEFAULT NULL,
language_code INT UNSIGNED DEFAULT '3',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
INDEX german_word_idx(word),
FOREIGN KEY (russian_code) REFERENCES russian(russian_code) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (language_code) REFERENCES languages(language_code) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO german (word, russian_code, audio) 
VALUES
('eins', '1', '1234500.wav'),
('zwei', '2', '2234500.wav'),
('drei', '3', '3234500.wav'),
('vier', '4', '4234500.wav'),
('fünf', '5', '5234500.wav'),
('sechs', '6', '6234500.wav'),
('sieben', '7', '7234500.wav'),
('acht', '8', '8234500.wav'),
('neun', '9', '9234500.wav'),
('zehn', '10', '1034500.wav');

-- Французский язык.

DROP TABLE IF EXISTS french;
CREATE TABLE french (
id SERIAL,
word VARCHAR(100) PRIMARY KEY,
russian_code INT UNSIGNED,
transcription VARCHAR(100) DEFAULT NULL,
audio VARCHAR(100) DEFAULT NULL,
language_code INT UNSIGNED DEFAULT '4',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
INDEX french_word_idx(word),
FOREIGN KEY (russian_code) REFERENCES russian(russian_code) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (language_code) REFERENCES languages(language_code) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO french (word, russian_code, audio) 
VALUES
('un', '1', '1034507.wav'),
('deux', '2', '2034507.wav'),
('trois', '3', '3034507.wav'),
('quatre', '4', '4034507.wav'),
('cinq', '5', '5034507.wav'),
('six', '6', '6034507.wav'),
('sept', '7', '7034507.wav'),
('huit', '8', '8034507.wav'),
('neuf', '9', '9034507.wav'),
('dix', '10', '1034507.wav');

-- Китайский язык.

DROP TABLE IF EXISTS chinese;
CREATE TABLE chinese (
id SERIAL,
word VARCHAR(100) PRIMARY KEY,
russian_code INT UNSIGNED,
transcription VARCHAR(100) DEFAULT NULL,
audio VARCHAR(100) DEFAULT NULL,
language_code INT UNSIGNED DEFAULT '5',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
INDEX chinese_word_idx(word),
FOREIGN KEY (russian_code) REFERENCES russian(russian_code) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (language_code) REFERENCES languages(language_code) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO chinese (word, russian_code, transcription, audio) 
VALUES
('一', '1', 'yī', '5234567.wav'),
('二', '2', 'èr', '5234567.wav'),
('三', '3', 'sān', '5234567.wav'),
('四', '4', 'sì', '5234567.wav'),
('五', '5', 'wǔ', '7234567.wav'),
('六', '6', 'liù', '5234567.wav'),
('七', '7', 'qī', '5234567.wav'),
('八', '8', 'bā', '5234567.wav'),
('九', '9', 'jiǔ', '5234567.wav'),
('十', '10', 'shí', '5034567.wav');

-- Пользователи.

DROP TABLE IF EXISTS users;
CREATE TABLE users (
id SERIAL PRIMARY KEY,
firstname VARCHAR(50),
lastname VARCHAR(50),
email VARCHAR(100) UNIQUE,
password_hash VARCHAR(100),
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
INDEX users_email_idx(email),
INDEX users_firstname_lastname_idx(firstname, lastname)
);

INSERT INTO users (firstname, lastname, email, password_hash) 
VALUES
('Иван', 'Лебедев', 'ivan_lebedev@example.org', '52a2fb61962fe88c0b96ef07d96fd278fe61cf4f'),
('Susan', 'Johnson', 'susan_johnson@example.org', '96cf25f3605e1dff77025bbbcd3cccee58d6ab4c'),
('Иван', 'Петров', 'ivan_petrov@example.org', '8447997dbbab422f81518a10cf639a11fc8588f3'),
('David', 'Aaron', 'david_aaron@example.org', '328f3ca368ee733b6b504fbc7432f6342662a2c7'),
('Gerhard', 'Schröder', 'schroeder@example.org', '14c8207d1397d33e4f4fef786ecd218bd194913e'),
('François', 'Hollande', 'hollande@example.org', '062a629043e8f4fc3e7934d3dedc0df174bf728c'),
('Κυριάκος', 'Μητσοτάκης', 'mitsotakis@example.org', '8f30d890b437f21a6bed26ea649bcaf73fbfe1a5'),
('近平', '习', 'xi_jinping@example.org', '87345f81a63b75c9afa58af59669a4e6b19a0c2d'),
('정은', '김', 'kim_jong-un@example.org', '8e8ebfb4f02e0249605f06b5339422f758faa09f'),
('カルロス', 'ゴーン', 'carlos_ghosn@example.org', '5e27c91515134016d65ce798393bb338835a456c');

-- Общая таблица со словами для повторения.

DROP TABLE IF EXISTS words_to_learn;
CREATE TABLE words_to_learn (
id SERIAL PRIMARY KEY,
word VARCHAR(100),
russian_code INT UNSIGNED,
transcription VARCHAR(100) DEFAULT NULL,
audio VARCHAR(100) DEFAULT NULL,
language_code INT UNSIGNED,
user_id BIGINT UNSIGNED NOT NULL,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
INDEX words_to_learn_idx(language_code, word),
FOREIGN KEY (russian_code) REFERENCES russian(russian_code) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (language_code) REFERENCES languages(language_code) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO words_to_learn (word, russian_code, transcription, audio, language_code, user_id, created_at, updated_at) 
VALUES
('deux', '2', NULL, '2034507.wav', '4', '2','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('cinq', '5', NULL, '5034507.wav', '4', '2','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('sept', '7', NULL, '7034507.wav', '4', '2','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('四', '4', 'sì', '5234567.wav', '5', '6','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('五', '5', 'wǔ', '7234567.wav', '5', '6','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('六', '6', 'liù', '5234567.wav', '5', '6','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('six', '6', NULL, '6034507.wav', '4', '3','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('eins', '1', NULL, '1234500.wav', '3', '3','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('zwei', '2', NULL, '2234500.wav', '3', '4','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('drei', '3', NULL, '3234500.wav', '3', '7','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('vier', '4', NULL, '4234500.wav', '3', '7','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('deux', '2', NULL, '2034507.wav', '4', '6','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('один', '1', NULL, '1234560.wav', '1', '7','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('два', '2', NULL, '2234560.wav', '1', '7','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('три', '3', NULL, '3234560.wav', '1', '7','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('七', '7', 'qī', '5234567.wav', '5', '10','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('八', '8', 'bā', '5234567.wav', '5', '9','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('eins', '1', NULL, '1234500.wav', '3', '2','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('zwei', '2', NULL, '2234500.wav', '3', '2','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('un', '1', NULL, '1034507.wav', '4', '7','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('deux', '2', NULL, '2034507.wav', '4', '7','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('deux', '2', NULL, '2034507.wav', '4', '10','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('trois', '3', NULL, '3034507.wav', '4', '7','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('quatre', '4', NULL, '4034507.wav', '4', '7','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('九', '9', 'jiǔ', '5234567.wav', '5', '8','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('十', '10', 'shí', '5034567.wav', '5', '7','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('huit', '8', NULL, '8034507.wav', '4', '1','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('neuf', '9', NULL, '9034507.wav', '4', '9','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('dix', '10', NULL, '1034507.wav', '4', '10','2021-03-01 15:45:12', '2021-03-02 20:00:00'),
('deux', '2', NULL, '2034507.wav', '4', '1','2021-03-01 15:45:12', '2021-03-02 20:00:00');

-- Варианты перевода слов, добавленные пользователями.

DROP TABLE IF EXISTS translations;
CREATE TABLE translations (
id SERIAL PRIMARY KEY,
word VARCHAR(100),
russian_code INT UNSIGNED,
translation VARCHAR(100),
language_code INT UNSIGNED,
user_id BIGINT UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
INDEX translations_idx(language_code, word),
FOREIGN KEY (russian_code) REFERENCES russian(russian_code) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (language_code) REFERENCES languages(language_code) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE SET NULL
);

INSERT INTO translations (word, russian_code, translation, language_code, user_id, created_at, updated_at) 
VALUES
('one', '1', 'единица', '2', '5','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('two', '2', 'двойка', '2', '5','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('two', '2', 'пара', '2', '5','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('three', '3', 'тройка', '2', '5','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('four', '4', 'четверка', '2', '5','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('five', '5', 'пятерка', '2', '5','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('eins', '1', 'единица', '3', '2','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('zwei', '2', 'двойка', '3', '2','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('zwei', '2', 'пара', '3', '2','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('drei', '3', 'тройка', '3', '2','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('vier', '4', 'четверка', '3', '2','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('fünf', '5', 'пятерка', '3', '2','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('sechs', '6', 'шестерка', '3', '2','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('sieben', '7', 'семерка', '3', '2','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('acht', '8', 'восьмерка', '3', '2','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('neun', '9', 'девятка', '3', '2','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('zehn', '10', 'десятка', '3', '2','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('six', '6', 'шестерка', '2', '1','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('seven', '7', 'семерка', '2', '1','2021-02-01 18:47:39', '2021-02-02 19:00:00'),
('eight', '8', 'восьмерка', '2', '3','2021-02-01 18:47:39', '2021-02-02 19:00:00');

-- Оценка вариантов перевода слов, добавленных пользователями.

DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
id SERIAL PRIMARY KEY,
user_id BIGINT UNSIGNED,
translation_id BIGINT UNSIGNED NOT NULL,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE SET NULL,
FOREIGN KEY (translation_id) REFERENCES translations(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO likes (user_id, translation_id, created_at)
VALUES 
('5','1','2021-03-20 11:20:25'),
('5','3','2021-03-20 11:20:25'),
('5','3','2021-03-20 11:20:25'),
('5','3','2021-03-20 11:20:25'),
('5','5','2021-03-20 11:20:25'),
('5','5','2021-03-20 11:20:25'),
('1','18','2021-03-20 11:20:25'),
('1','19','2021-03-20 11:20:25'),
('3','20','2021-03-20 11:20:25'),
('1','18','2021-03-20 11:20:25'); 
