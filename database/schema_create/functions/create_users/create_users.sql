INSERT INTO app_user (username, email, password_hash)
SELECT 
    'user_' || seq AS username,
    'user' || seq || '@example.com' AS email,
    md5(random()::text) AS password_hash
FROM generate_series(1, 10000) AS seq;
