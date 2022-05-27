/*
Задача 1. Перевод с русского языка на иностранный. Три первых слова из таблицы russian перевести на китайский язык.
*/

USE lingvo;
SELECT ru.word AS "Русский", ch.word AS "Китайский" FROM russian ru JOIN chinese ch ON ru.russian_code = ch.russian_code ORDER BY ru.id LIMIT 3;

/*
Задача 2. Перевод с одного иностранного языка на другой иностранный язык. Слово sieben перевести с немецкого языка на английский.
*/

USE lingvo;
SELECT ge.word AS "Немецкий", en.word AS "Английский" FROM german ge JOIN english en ON ge.russian_code = en.russian_code WHERE ge.word = "sieben";

/*
Задача 3. Определить, какие слова сохранил для повторения заданный пользователь (id = 7). Указать язык для каждого слова.
*/

USE lingvo;
SELECT wtl.word AS Word, la.language AS Language FROM words_to_learn wtl JOIN languages la ON wtl.language_code = la.language_code WHERE wtl.user_id = 7 ORDER BY la.language_code;

/*
Задача 4. Определить, какие слова пользователи чаще всего сохраняют для повторения. Указать язык для каждого слова.
*/

USE lingvo;
SELECT wtl.word AS Word, COUNT(*) AS Quantity, la.language AS Language FROM words_to_learn wtl JOIN languages la ON wtl.language_code = la.language_code GROUP BY wtl.word ORDER BY Quantity DESC;

/*
Задача 5. Определить имя и фамилию пользователя, который больше всех добавил своих вариантов перевода слов.
*/

USE lingvo;
SELECT u.firstname AS First_Name, u.lastname AS Last_Name, COUNT(tr.user_id) AS Quantity FROM users u JOIN translations tr ON u.id = tr.user_id GROUP BY tr.user_id ORDER BY Quantity DESC LIMIT 1;

/*
Задача 6. Вывести имена и фамилии пользователей, которые сохранили для повторения слова французского языка.
*/

USE lingvo;
SELECT u.firstname AS First_Name, u.lastname AS Last_Name FROM users u JOIN words_to_learn wtl ON u.id = wtl.user_id WHERE wtl.language_code = (SELECT language_code FROM languages WHERE language = "французский") GROUP BY u.id ORDER BY u.id;
