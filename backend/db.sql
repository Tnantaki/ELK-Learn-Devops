CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(20) UNIQUE NOT NULL,
  password VARCHAR(20) UNIQUE NOT NULL,
);

CREATE TABLE auths (
  auth_id SERIAL PRIMARY KEY,
  token VARCHAR(20) NOT NULL,
  user_id INT NOT NULL UNIQUE REFERENCES users(id)
);

CREATE TABLE profiles (
  profile_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL UNIQUE REFERENCES users(id),
  name VARCHAR(20) UNIQUE NOT NULL,
  avatar_path TEXT,
  email VARCHAR(255)
);

CREATE TABLE match_histories (
  match_id SERIAL PRIMARY KEY,
  player1_id INT NOT NULL REFERENCES users(id),
  player2_id INT NOT NULL REFERENCES users(id),
  score1 INT NOT NULL DEFAULT 0,
  score2 INT NOT NULL DEFAULT 0,
  startDate DATE NOT NULL,
  duration INT
);

CREATE TABLE status (
  status_id SERIAL PRIMARY KEY,
  fight INT NOT NULL DEFAULT 0,
  wins INT NOT NULL DEFAULT 0,
  losses INT NOT NULL DEFAULT 0,
  profile_id INT NOT NULL UNIQUE REFERENCES profiles(profile_id)
);

CREATE TABLE friends (
  friend_id SERIAL PRIMARY KEY,
  my_profile_id INT NOT NULL REFERENCES profiles(profile_id),
  friend_profile_id INT NOT NULL REFERENCES profiles(profile_id),
  status SET ('accept', 'pending', 'block') NOT NULL
);
