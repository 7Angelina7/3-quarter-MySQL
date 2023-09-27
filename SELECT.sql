USE wiki;
                                                   -- Скрипты характерных выборок

-- 1) Выборка статей и их обсуждений.
SELECT 
    a.name AS article,
    d.body AS discussion
FROM articles a 
JOIN discussions d ON d.articles_id = a.id;


-- 2) Выборка статей, созданных после 1 января 2020 года.

SELECT
    a.name,
    h.created_at 
FROM articles a 
JOIN history h ON a.id = h.articles_id 
WHERE h.created_at > '2020-01-01'
ORDER BY created_at;

-- 3) Выборка людей, входящих в проект, в котором есть статья с id = 1.

SELECT
    u.firstname,
    u.lastname,
    p.name AS project, 
    a.name AS article
FROM  users u 
JOIN discussions d ON u.id = d.user_id 
JOIN articles a ON d.articles_id = a.id 
JOIN projects_articles pa ON a.id = pa.articles_id 
JOIN projects p ON p.id = pa.projects_id 
WHERE a.id = 1;


-- 4) Выборка литературы статьи с id = 4.

SELECT 
    l.body 
FROM literature l 
JOIN notes n ON l.notes_id = n.id 
JOIN articles a ON a.id = n.articles_id 
WHERE a.id = 4;


-- 5) Выборка форумов, в которых обсуждаются статьи, обновленные до 1971 года.

SELECT 
    f.name AS forum,
    a.name AS article,
    a.updated_at 
FROM forums f 
JOIN forums_articles fa ON f.id = fa.forums_id 
JOIN articles a ON a.id = fa.articles_id 
WHERE a.updated_at < '1971-01-01';


-- 6) Категории статей, которых корректировали в 2023 году.

SELECT 
    c.name AS category
FROM categories c 
JOIN categories_articles ca ON c.id =ca.categories_id 
JOIN articles a ON a.id = ca.articles_id 
JOIN corrections c2 ON a.id = c2.articles_id 
WHERE c2.created_at > '2022-12-31';

-- 7) Количество проектов у каждой статьи.

SELECT 
    COUNT(*) AS total_projects,
    a.name AS articles
   -- p.name AS projects
FROM articles a 
JOIN projects_articles pa ON a.id = pa.articles_id 
JOIN projects p  ON p.id = pa.projects_id 
GROUP BY a.name;

                                                    -- Представления.

-- 1) Выборка статей, созданных после 1 января 2020 года.

CREATE OR REPLACE VIEW v_new
AS
SELECT
    a.name,
    h.created_at 
FROM articles a 
JOIN history h ON a.id = h.articles_id 
WHERE h.created_at > '2020-01-01'
ORDER BY created_at;

-- исполнение
SELECT * FROM v_new
ORDER BY created_at;

-- 2) Выборка правок определенного пользователя.

CREATE OR REPLACE VIEW v_new2
AS
SELECT 
    c.user_id,
    c.body 
FROM corrections c 
WHERE c.user_id = 20;

SELECT * FROM v_new2;


                                                             -- Хранимые процедуры.

-- 1) Выборка людей, входящих в проект, в котором есть статья с id = 1.

DROP PROCEDURE IF EXISTS sp_users_project;
DELIMITER //
CREATE PROCEDURE sp_users_project(for_user_id BIGINT)
BEGIN
	SELECT
    u.firstname,
    u.lastname,
    p.name AS project, 
    a.name AS article
FROM  users u 
JOIN discussions d ON u.id = d.user_id 
JOIN articles a ON d.articles_id = a.id 
JOIN projects_articles pa ON a.id = pa.articles_id 
JOIN projects p ON p.id = pa.projects_id 
WHERE a.id =1 AND for_user_id = u.id;
END//
DELIMITER ;

CALL sp_users_project(26);


-- 2) Количество проектов у определенной статьи.


DROP PROCEDURE IF EXISTS sp_projects;
DELIMITER //
CREATE PROCEDURE sp_projects(article_id BIGINT)
BEGIN
	SELECT 
    COUNT(*) AS total_projects,
    p.articles_id AS articles
FROM projects p
JOIN projects_articles pa ON p.id = pa.projects_id 
JOIN articles a  ON a.id = pa.articles_id 
WHERE p.articles_id = article_id 
GROUP BY p.articles_id;	
END//
DELIMITER ;

CALL sp_projects(13);



                                                            -- Триггеры.
USE wiki;

-- Триггер на добавление

DELIMITER $$
$$
CREATE TRIGGER check_article_created_at_before_insert
BEFORE INSERT
ON articles FOR EACH ROW
BEGIN
	IF NEW.created_at > current_date() THEN 
	    SET NEW.created_at = current_date();
	END IF;   
END
$$
DELIMITER ;



USE wiki;
 -- Триггер на изменение

DELIMITER $$
$$
CREATE TRIGGER check_article_created_at_before_update
BEFORE UPDATE
ON articles FOR EACH ROW
BEGIN 
	IF NEW.created_at > current_date() THEN 
	    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Сработал триггер! Обновление отменено. Неправильно указана дата добавления!';
	END IF;   
END
$$
DELIMITER ;



-- добавим статью
INSERT INTO articles (name, body, created_at, updated_at)
        VALUES('','','2030-01-01','2020-01-01');     

SELECT * FROM articles a 
ORDER BY a.id DESC;  -- проставилась текущая дата


-- Изменяем дату
UPDATE articles 
SET created_at = '2030-01-01'
WHERE id=101;    -- ошибка


















