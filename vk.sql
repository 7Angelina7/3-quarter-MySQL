DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    firstname VARCHAR(100),
    lastname VARCHAR(100) COMMENT 'ФАМИЛИЯ',
    email VARCHAR(120) UNIQUE,
    password_hash VARCHAR(100),
    phone BIGINT UNSIGNED,
    is_deleted BIT DEFAULT b'0',
    INDEX users_lastname_firstname_idx(lastname, firstname)
); 

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
    user_id SERIAL PRIMARY KEY,
    gender CHAR(1),
    birthday DATE,
    photo_id BIGINT UNSIGNED,
    create_at DATETIME DEFAULT NOW(),
    hometown_id BIGINT UNSIGNED NOT NULL
); 

ALTER TABLE profiles ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE;
    
DROP TABLE IF EXISTS messages;
CREATE TABLE massages (
    id SERIAL PRIMARY KEY,
    from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    creted_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (from_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (to_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
    );
    
DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
    -- id SERIAL PRIMARY KEY,
    initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'declined', 'unfriended'),
    requested_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NOW(),
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (target_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
    id SERIAL PRIMARY KEY,
    name VARCHAR(150),
    INDEX communities_name_idx(name)
    );

DROP TABLE IF EXISTS users_communities; 
CREATE TABLE users_communities(
    user_id BIGINT UNSIGNED NOT NULL,
    communities_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (user_id, communities_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (communities_id) REFERENCES communities(id) ON UPDATE CASCADE ON DELETE CASCADE
    );
   

DROP TABLE IF EXISTS media_types;   
CREATE TABLE media_types(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
    );


DROP TABLE IF EXISTS media;
CREATE TABLE media(
    id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    media_type_id BIGINT UNSIGNED,
    filename VARCHAR(255),
    `size` INT,
    metadata JSON,
    creted_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (media_type_id) REFERENCES media_types(id) ON UPDATE CASCADE ON DELETE CASCADE
    );
   
DROP TABLE IF EXISTS likes;
CREATE TABLE likes( 
    id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE
    );
   
DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums`(
    `id` SERIAL,
    `name` VARCHAR(255) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (`id`)
    );
   
DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos`(
    id SERIAL PRIMARY KEY,
    `album_id` BIGINT unsigned NOT NULL,
    `media_id` BIGINT unsigned NOT NULL,
    FOREIGN KEY (album_id) REFERENCES photo_albums(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
    );
   
ALTER TABLE profiles ADD CONSTRAINT fk_photo_id
FOREIGN KEY (photo_id) REFERENCES photos(id) ON UPDATE CASCADE ON DELETE CASCADE;   


-- Домашнее задание 3


-- таблица города, связь 1-М
DROP TABLE IF EXISTS hometowns;
CREATE TABLE hometowns(
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	name VARCHAR(255),
	FOREIGN KEY(user_id) REFERENCES users(id)
);

-- Добавляем ссылки на таблицы media и hometowns
ALTER TABLE profiles ADD CONSTRAINT fk_photo_id
FOREIGN KEY (photo_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE; 

ALTER TABLE profiles ADD CONSTRAINT fk_hometown_id
FOREIGN KEY (hometown_id) REFERENCES hometowns(id) ON UPDATE CASCADE ON DELETE CASCADE; 
 

-- таблица посты пользователей, связь 1-М
DROP TABLE IF EXISTS posts;
CREATE TABLE posts(
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY(user_id) REFERENCES users(id)
);

-- таблица лайки постов, связь 1-М
DROP TABLE IF EXISTS like_posts;
CREATE TABLE like_posts(
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	posts_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(posts_id) REFERENCES posts(id)
);



   