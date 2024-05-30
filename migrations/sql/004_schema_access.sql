\c berli

-- SESSION MAGIC LINK
CREATE TABLE access."magic_link" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT session_magic_pkey PRIMARY KEY,
    entity_id uuid NOT NULL UNIQUE,
    session_id VARCHAR NOT NULL,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- EMAIL SUBSCRIPTION
CREATE TABLE access."email_subscription" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
    email VARCHAR(89) NOT NULL UNIQUE,
    changes VARCHAR(45) NOT NULL,
    token uuid DEFAULT uuid_generate_v4() NOT NULL,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL
);
