\c berli

-- COMPANY
CREATE TABLE users."company" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT company_pkey PRIMARY KEY,
    email VARCHAR(89) NOT NULL CONSTRAINT email_company_unique UNIQUE,
    avatar_id INTEGER NOT NULL CONSTRAINT fk_avatar REFERENCES berli."avatar" (id),
    company_tax_id VARCHAR(120) NOT NULL, -- Partita IVA
    pec VARCHAR(120), -- Posta Eletronica Certificata
    is_active BOOLEAN NOT NULL DEFAULT true,
    language VARCHAR(8) DEFAULT 'it' NOT NULL CHECK (language IN ('en', 'it', 'es')),
    name VARCHAR(100) NOT NULL,
    industry VARCHAR(100) NOT NULL,
    contact VARCHAR(89) NOT NULL,
    area_code VARCHAR(5) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address_line VARCHAR(60) NOT NULL,
    zip_code VARCHAR(60) NOT NULL,
    city VARCHAR(30) NOT NULL,
    country VARCHAR(20) NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- STAFF
CREATE TABLE users."staff" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT staff_pkey PRIMARY KEY,
    email VARCHAR(89) NOT NULL CONSTRAINT email_staff_unique UNIQUE,
    name VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    avatar_id INTEGER NOT NULL CONSTRAINT fk_avatar REFERENCES berli."avatar" (id),
    company_id uuid NOT NULL,
    iban VARCHAR(120),
    resident_permit VARCHAR(40), -- Permesso di soggiorno
    tax_id VARCHAR(40) NOT NULL, -- Codice fiscale
    national_id_card VARCHAR(40) NOT NULL, -- Carta di Identita
    passport VARCHAR(20),
    is_active BOOLEAN NOT NULL DEFAULT true,
    language VARCHAR(8) DEFAULT 'it' NOT NULL CHECK (language IN ('en', 'it', 'es')),
    position VARCHAR(100) NOT NULL,
    contact VARCHAR(89) NOT NULL,
    area_code VARCHAR(5) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address_line VARCHAR(60) NOT NULL,
    zip_code VARCHAR(60) NOT NULL,
    city VARCHAR(30) NOT NULL,
    country VARCHAR(20) NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (company_id) REFERENCES users."company"(id)
);

-- CLIENT
CREATE TABLE users."client" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT client_pkey PRIMARY KEY,
    email VARCHAR(89) NOT NULL CONSTRAINT email_client_unique UNIQUE,
    name VARCHAR(100) NOT NULL,
    avatar_id INTEGER NOT NULL CONSTRAINT fk_avatar REFERENCES berli."avatar" (id),
    company_id uuid NOT NULL,
    company_tax_id VARCHAR(120) NOT NULL, -- Partita IVA
    pec VARCHAR(120), -- Posta Eletronica Certificata
    language VARCHAR(8) DEFAULT 'it' NOT NULL CHECK (language IN ('en', 'it', 'es')),
    industry VARCHAR(100) NOT NULL,
    contact VARCHAR(89) NOT NULL,
    area_code VARCHAR(5) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address_line VARCHAR(60) NOT NULL,
    zip_code VARCHAR(60) NOT NULL,
    city VARCHAR(30) NOT NULL,
    country VARCHAR(20) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (company_id) REFERENCES users."company"(id)
);

-- EMPLOYEE
CREATE TABLE users."employee" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT employee_pkey PRIMARY KEY,
    email VARCHAR(89) NOT NULL CONSTRAINT employee_client_unique UNIQUE,
    name VARCHAR(40) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    avatar_id INTEGER NOT NULL CONSTRAINT fk_avatar REFERENCES berli."avatar" (id),
    company_id uuid NOT NULL,
    client_id uuid NOT NULL,
    iban VARCHAR(120),
    resident_permit VARCHAR(40), -- Permesso di soggiorno
    tax_id VARCHAR(40) NOT NULL, -- Codice fiscale
    national_id_card VARCHAR(40) NOT NULL, -- Carta di Identita
    passport VARCHAR(20), -- Passport
    language VARCHAR(8) DEFAULT 'it' NOT NULL CHECK (language IN ('en', 'it', 'es')),
    position VARCHAR(100) NOT NULL,
    contact VARCHAR(89) NOT NULL,
    area_code VARCHAR(5) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address_line VARCHAR(60) NOT NULL,
    zip_code VARCHAR(60) NOT NULL,
    city VARCHAR(30) NOT NULL,
    country VARCHAR(20) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (company_id) REFERENCES users."company"(id),
    FOREIGN KEY (client_id) REFERENCES users."client"(id)
);
