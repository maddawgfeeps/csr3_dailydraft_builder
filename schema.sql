-- CSR3 Daily Draft Builder account + profile persistence schema
-- Compatible with SQLite / PostgreSQL-style SQL.

CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY,
  username VARCHAR(64) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS garages (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL UNIQUE,
  garage_data TEXT NOT NULL DEFAULT '{}',
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_garages_users FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS user_profiles (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL UNIQUE,
  profile_data TEXT NOT NULL DEFAULT '{"trackOverrides":{},"viableOverrides":{},"carAttributeOverrides":{}}',
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_user_profiles_users FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_garages_user_id ON garages(user_id);
CREATE INDEX IF NOT EXISTS idx_user_profiles_user_id ON user_profiles(user_id);