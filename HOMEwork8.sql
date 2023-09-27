USE vk;

-- 1) Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT m.from_user_id,
       COUNT(*) AS total
FROM messages m 
JOIN users u ON m.from_user_id = u.id 
JOIN friend_requests fr ON u.id = fr.initiator_user_id OR u.id = fr.target_user_id
WHERE (fr.initiator_user_id =1 OR fr.target_user_id =1) AND fr.status = 'approved' AND to_user_id =1
GROUP BY from_user_id
ORDER BY total DESC;
  
-- 2) Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.

SELECT COUNT(*) likes_total
FROM likes l
JOIN media m ON m.id = l.media_id
JOIN users u  ON m.user_id = u.id
JOIN profiles p ON p.user_id = u.id 
WHERE TIMESTAMPDIFF(YEAR, birthday,NOW())<12;


-- 3) Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT COUNT(*) AS likes, gender 
FROM likes l
JOIN users u ON l.user_id = u.id 
JOIN profiles p ON u.id = p.user_id 
WHERE l.user_id = p.user_id
GROUP BY gender;