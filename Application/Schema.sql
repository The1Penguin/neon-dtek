CREATE FUNCTION set_updated_at_to_now() RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language plpgsql;
-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL UNIQUE,
    hashed_password TEXT NOT NULL,
    session_id UUID DEFAULT uuid_generate_v4() NOT NULL
);
CREATE TABLE posts (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    user_id UUID NOT NULL,
    image TEXT DEFAULT NULL,
    title TEXT NOT NULL,
    body TEXT DEFAULT NULL,
    occurs_at DATE NOT NULL
);
CREATE INDEX posts_created_at_index ON posts (created_at);
CREATE TRIGGER update_posts_updated_at BEFORE UPDATE ON posts FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
CREATE INDEX posts_user_id_index ON posts (user_id);
ALTER TABLE posts ADD CONSTRAINT posts_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
