/* Курсовой проект. Основы реляционных баз данных. MySQL. 
В проекте создается база данных свободной энциклопедии, которую можно редактировать любым пользователем. 
База данных состоит из таблиц (сущностей):
•	статьи (articles)
•	категории статей (categories)
•	правки статей (corrections)
•	обсуждения статей (discussions)
•	форумы (forums)
•	история изменений статьи (history)
•	использованная литература (literature)
•	примечания на литературу (notes)
•	проекты (projects)
•	пользователи (users)
•	категории – статьи (categories_articles)
•	форумы – статьи (forums_articles)
•	проекты – статьи (projects_articles)
Любой пользователь регистрируется в системе (таблица пользователи), находит статью по категории или по названию. 
Есть возможность редактирования статьи, что фиксируется в таблицах правки и история изменений. 
К каждой статье прикреплено обсуждение, где можно оставить свое мнение о ней. 
Для пользователей системы есть форумы и проекты, где можно использовать сразу несколько статей. 
Примечания и литература – неотъемлемая часть статьи, которые хранятся в одноименных таблицах.
Таблицы категории – статьи, форумы – статьи, проекты – статьи являются переходными.
База данных позволяет вести учет статей, контролировать изменения, внесенные пользователями, создавать проекты, вести форумы.
*/

DROP DATABASE IF EXISTS wiki;
CREATE DATABASE wiki;
USE wiki;


DROP TABLE IF EXISTS articles; -- статьи
CREATE TABLE articles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    -- categories_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NOW(),
    INDEX articles_name_idx(name)
    );
    
   
DROP TABLE IF EXISTS history;  -- история изменений
CREATE TABLE history (
    id SERIAL PRIMARY KEY,
    articles_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (articles_id) REFERENCES articles(id) ON UPDATE CASCADE ON DELETE CASCADE -- связь 1-M
    );
    
    
DROP TABLE IF EXISTS forums;  -- форум
CREATE TABLE forums (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW()
    );   
    
DROP TABLE IF EXISTS projects;  -- проекты
CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    status ENUM('активный', 'малоактивный', 'новый', 'неактивный'),
    articles_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW()
    ); 
   
DROP TABLE IF EXISTS notes;  -- примечания
CREATE TABLE notes (
    id SERIAL PRIMARY KEY,
    body TEXT,
    articles_id BIGINT UNSIGNED NOT NULL,
    -- literature_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (articles_id) REFERENCES articles(id) ON UPDATE CASCADE ON DELETE CASCADE -- связь 1-M
    );   
    
DROP TABLE IF EXISTS literature;  -- литература
CREATE TABLE literature (
    id SERIAL PRIMARY KEY,
    body TEXT,
    notes_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (id) REFERENCES notes(id) ON UPDATE CASCADE ON DELETE CASCADE  -- связь 1-1 
    );     
   
DROP TABLE IF EXISTS categories;  -- категории статей
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    articles_id BIGINT UNSIGNED NOT NULL
    );
   
   
DROP TABLE IF EXISTS users; -- пользователи
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    firstname VARCHAR(100),
    lastname VARCHAR(100),
    email VARCHAR(120) UNIQUE,
    password_hash VARCHAR(100),
    phone BIGINT UNSIGNED,
    is_deleted BIT DEFAULT b'0'
);     
   
DROP TABLE IF EXISTS corrections;  -- правки пользователя в статьях
CREATE TABLE corrections ( 
    id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    articles_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (id) REFERENCES history(id) ON UPDATE CASCADE ON DELETE CASCADE, -- связь 1-1 
    FOREIGN KEY (articles_id) REFERENCES articles(id) ON UPDATE CASCADE ON DELETE CASCADE,-- связь 1-M
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE -- связь 1-M 
    );
   


DROP TABLE IF EXISTS discussions;  -- обсуждения статьи пользователями
CREATE TABLE discussions (
    id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    articles_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,-- связь 1-M 
    FOREIGN KEY (id) REFERENCES articles(id) ON UPDATE CASCADE ON DELETE CASCADE -- связь 1-1
    ); 
   
DROP TABLE IF EXISTS categories_articles; -- промежуточная таблица categories_articles
CREATE TABLE categories_articles(
    categories_id BIGINT UNSIGNED NOT NULL,
    articles_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (categories_id, articles_id),
    FOREIGN KEY (categories_id) REFERENCES categories(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (articles_id) REFERENCES articles(id) ON UPDATE CASCADE ON DELETE CASCADE -- связь М-М
    );
   
DROP TABLE IF EXISTS projects_articles; -- промежуточная таблица projects_articles
CREATE TABLE projects_articles(
    projects_id BIGINT UNSIGNED NOT NULL,
    articles_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (projects_id, articles_id),
    FOREIGN KEY (projects_id) REFERENCES projects(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (articles_id) REFERENCES articles(id) ON UPDATE CASCADE ON DELETE CASCADE -- связь М-М
    );  
    
DROP TABLE IF EXISTS forums_articles; -- промежуточная таблица forums_articles
CREATE TABLE forums_articles(
    forums_id BIGINT UNSIGNED NOT NULL,
    articles_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (forums_id, articles_id),
    FOREIGN KEY (forums_id) REFERENCES forums(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (articles_id) REFERENCES articles(id) ON UPDATE CASCADE ON DELETE CASCADE -- связь М-М
    );
    
    
  
