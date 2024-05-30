\c berli

-- AVATAR
CREATE TABLE berli."avatar" (
    id SERIAL NOT NULL PRIMARY KEY,
    avatar VARCHAR(13) NOT NULL
);

-- AGENT
CREATE TABLE berli."agent" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT berli_agent_pkey PRIMARY KEY,
    email VARCHAR(89) NOT NULL CONSTRAINT email_berli_unique UNIQUE,
    name VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    avatar_id INTEGER NOT NULL CONSTRAINT fk_avatar REFERENCES berli."avatar" (id),
    role VARCHAR(10) NOT NULL DEFAULT 'support' CHECK (role IN ('admin', 'support', 'managment', 'sales')),
    language VARCHAR(8) DEFAULT 'it' NOT NULL CHECK (language IN ('en', 'it', 'es')),
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Insert avatar values
INSERT INTO berli."avatar" (avatar)
VALUES ('arbol'), ('cuak'), ('loved'), ('ricio'),
('best'), ('dog'), ('mario'), ('rosa'),
('biondino'), ('lion'), ('playa'), ('rust'),
('cat'), ('llama'), ('py'), ('suerte');
