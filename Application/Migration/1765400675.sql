CREATE FUNCTION set_updated_at_to_now() RETURNS TRIGGER AS $$BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;$$ language PLPGSQL;
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    hashed_password TEXT NOT NULL,
    session_id UUID DEFAULT uuid_generate_v4() NOT NULL
);
ALTER TABLE users ADD CONSTRAINT users_name_key UNIQUE(name);
