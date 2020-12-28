-- 1) Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользоваетелем.

SELECT count(*) mess, friend FROM 
	(SELECT text, to_Users_id AS friend FROM messages WHERE from_users_id = 10
	 UNION
	 SELECT text,from_users_id AS friend FROM messages WHERE to_users_id = 10) as history

GROUP BY friend
ORDER BY mess DESC
LIMIT 1
;


-- 2) Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей

SELECT count(*) as total_likes FROM likes as m WHERE users_id IN (
	SELECT users_id FROM likes 
	WHERE users_id IN (
		SELECT * FROM (
			SELECT users_id FROM profles ORDER by birthday DESC LIMIT 10
		) as users_id		
	)
)
;

-- 3) Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT gender FROM (
	SELECT "m" as gender, COUNT(*) as total FROM likes WHERE users_id IN (SELECT users_id FROM profles as p WHERE gender='m')
	UNION
	SELECT "f" as gender, COUNT(*) as total FROM likes WHERE users_id IN (SELECT users_id FROM profles as p WHERE gender='f')
) as my_sort
ORDER BY total DESC
LIMIT 1
;



-- 4) Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

SELECT (SELECT firstname FROM users where id = users_id) firstname,  SUM(T.rnk) AS activ
FROM(
	SELECT from_users_id as users_id, COUNT(*) as rnk  FROM messages -- Неактивные пользователи мало отправляют сообщения
	GROUP BY from_users_id
	UNION ALL
	SELECT users_id, COUNT(*)  FROM likes -- Неактивные пользователи мало лайкуют
	GROUP BY users_id
	UNION ALL
	SELECT from_Users_id, COUNT(*)  FROM friend_requests -- И друзей у таких пользователей мало
	GROUP BY from_Users_id
	UNION ALL
	-- SELECT from_Users_id, COUNT(*)  FROM friend_requests 
	-- GROUP BY from_Users_id
	-- UNION ALL
	SELECT Users_id, COUNT(*)  FROM users_communities
	GROUP BY Users_id
) AS T
GROUP BY firstname
ORDER BY activ
LIMIT 10;
