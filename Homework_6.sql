USE vk;

-- 1) Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

SELECT * FROM friend_requests
WHERE status = 'approved' AND (initiator_user_id = 1 OR target_user_id = 1);

 
SELECT
    from_user_id, to_user_id,
    COUNT(*) AS total
FROM messages
WHERE (from_user_id =1 OR to_user_id =1) AND (from_user_id IN (3,4,10) OR to_user_id IN (3,4,10))
GROUP BY from_user_id, to_user_id;

-- 2) Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.

SELECT 
    COUNT(*) AS likes_total
FROM likes
WHERE user_id IN (SELECT user_id FROM profiles WHERE YEAR(CURDATE()) - YEAR(birthday) < 12);

-- 3) Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT 
    COUNT(user_id) AS total
FROM likes 
WHERE user_id IN (SELECT user_id FROM profiles WHERE gender = 'f');

SELECT 
    COUNT(user_id) AS total
FROM likes 
WHERE user_id IN (SELECT user_id FROM profiles WHERE gender = 'm');


SELECT COUNT(*) AS likes, gender 
FROM likes, profiles
WHERE likes.user_id = profiles.user_id
GROUP BY gender;
