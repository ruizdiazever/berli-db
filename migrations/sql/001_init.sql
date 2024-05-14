-- DB
\c berli

-- SCHEMAS
CREATE SCHEMA IF NOT EXISTS berli;
CREATE SCHEMA IF NOT EXISTS users;
CREATE SCHEMA IF NOT EXISTS permissions;
CREATE SCHEMA IF NOT EXISTS support;
CREATE SCHEMA IF NOT EXISTS projects;

-- UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
SELECT uuid_generate_v4();

-- AVATAR
CREATE TABLE users."avatar" (
    id SERIAL NOT NULL PRIMARY KEY,
    avatar VARCHAR(13) NOT NULL
);

-- BERLI
CREATE TABLE berli."agent" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT berli_agent_pkey PRIMARY KEY,
    avatar_id INTEGER NOT NULL CONSTRAINT fk_avatar REFERENCES users."avatar" (id),
    email VARCHAR(89) NOT NULL CONSTRAINT email_berli_unique UNIQUE,
    name VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    role VARCHAR(10) NOT NULL DEFAULT 'support' CHECK (role IN ('admin', 'support', 'managment')),
    language VARCHAR(8) DEFAULT 'it' NOT NULL CHECK (language IN ('en', 'it', 'es')),
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- COMPANY
CREATE TABLE users."company" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT company_pkey PRIMARY KEY,
    email VARCHAR(89) NOT NULL CONSTRAINT email_company_unique UNIQUE,
    avatar_id INTEGER NOT NULL CONSTRAINT fk_avatar REFERENCES users."avatar" (id),
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
    company_id uuid NOT NULL,
    iban VARCHAR(120),
    resident_permit VARCHAR(40), -- Permesso di soggiorno
    tax_id VARCHAR(40) NOT NULL, -- Codice fiscale
    national_id_card VARCHAR(40) NOT NULL, -- Carta di Identita
    passport VARCHAR(20),
    is_active BOOLEAN NOT NULL DEFAULT true,
    avatar_id INTEGER NOT NULL CONSTRAINT fk_avatar REFERENCES users."avatar" (id),
    language VARCHAR(8) DEFAULT 'it' NOT NULL CHECK (language IN ('en', 'it', 'es')),
    name VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
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
    company_id uuid NOT NULL,
    company_tax_id VARCHAR(120) NOT NULL, -- Partita IVA
    pec VARCHAR(120), -- Posta Eletronica Certificata
    language VARCHAR(8) DEFAULT 'it' NOT NULL CHECK (language IN ('en', 'it', 'es')),
    avatar_id INTEGER NOT NULL CONSTRAINT fk_avatar REFERENCES users."avatar" (id),
    name VARCHAR(100) NOT NULL,
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
    company_id uuid NOT NULL,
    client_id uuid NOT NULL,
    iban VARCHAR(120),
    resident_permit VARCHAR(40), -- Permesso di soggiorno
    tax_id VARCHAR(40) NOT NULL, -- Codice fiscale
    national_id_card VARCHAR(40) NOT NULL, -- Carta di Identita
    passport VARCHAR(20), -- Passport
    avatar_id INTEGER NOT NULL CONSTRAINT fk_avatar REFERENCES users."avatar" (id),
    language VARCHAR(8) DEFAULT 'it' NOT NULL CHECK (language IN ('en', 'it', 'es')),
    name VARCHAR(40) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
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

-- SESSION MAGIC LINK
CREATE TABLE users."session" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT session_magic_pkey PRIMARY KEY,
    entity_id uuid NOT NULL,
    session_id VARCHAR NOT NULL,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    FOREIGN KEY (entity_id) REFERENCES users."company"(id),
    FOREIGN KEY (entity_id) REFERENCES users."staff"(id),
    FOREIGN KEY (entity_id) REFERENCES users."employee"(id),
    FOREIGN KEY (entity_id) REFERENCES users."client"(id)
);

-- PROJECT
CREATE TABLE projects."project" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT project_pkey PRIMARY KEY,
    client_id uuid NOT NULL,
    created_by uuid NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (client_id) REFERENCES users."client"(id),
    FOREIGN KEY (created_by) REFERENCES users."client"(id),
    FOREIGN KEY (created_by) REFERENCES users."staff"(id)
);

-- PROJECT EMPLOYEE
CREATE TABLE projects."project_employee" (
    project_id uuid NOT NULL,
    employee_id uuid NOT NULL,
    PRIMARY KEY (project_id, employee_id),
    FOREIGN KEY (project_id) REFERENCES projects."project"(id),
    FOREIGN KEY (employee_id) REFERENCES users."employee"(id)
);

-- ENTITIES PERMISSIONS
CREATE TABLE permissions."system" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT permissions_system_pkey PRIMARY KEY,
    entity_id uuid NOT NULL,
    can_grant BOOLEAN NOT NULL DEFAULT false,
    can_revoke BOOLEAN NOT NULL DEFAULT false,
    can_self_update BOOLEAN NOT NULL DEFAULT false,
    can_upload_hours BOOLEAN NOT NULL DEFAULT false,
    can_upload_docs BOOLEAN NOT NULL DEFAULT false,
    can_remove_docs BOOLEAN NOT NULL DEFAULT false,
    can_create_employee BOOLEAN NOT NULL DEFAULT false,
    can_edit_employee BOOLEAN NOT NULL DEFAULT false,
    can_edit_client BOOLEAN NOT NULL DEFAULT false,
    can_remove_employee BOOLEAN NOT NULL DEFAULT false,
    can_remove_client BOOLEAN NOT NULL DEFAULT false,
    can_modify_calendar BOOLEAN NOT NULL DEFAULT false,
    FOREIGN KEY (entity_id) REFERENCES berli."agent"(id),
    FOREIGN KEY (entity_id) REFERENCES users."company"(id),
    FOREIGN KEY (entity_id) REFERENCES users."client"(id),
    FOREIGN KEY (entity_id) REFERENCES users."staff"(id),
    FOREIGN KEY (entity_id) REFERENCES users."employee"(id)
);

-- FILE PERMISSIONS
CREATE TABLE permissions."file" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT permissions_file_pkey PRIMARY KEY,
    entity_id uuid NOT NULL,
    can_view BOOLEAN DEFAULT false,
    can_download BOOLEAN DEFAULT false,
    FOREIGN KEY (entity_id) REFERENCES berli."agent"(id),
    FOREIGN KEY (entity_id) REFERENCES users."company"(id),
    FOREIGN KEY (entity_id) REFERENCES users."client"(id),
    FOREIGN KEY (entity_id) REFERENCES users."staff"(id),
    FOREIGN KEY (entity_id) REFERENCES users."employee"(id)
);

-- SUPPORT CONTACT
CREATE TABLE support."generic" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    entity_id uuid NOT NULL,
    email_input VARCHAR(89) NOT NULL,
    msg_input VARCHAR(240) NOT NULL,
    msg_dev VARCHAR(240) NOT NULL,
    browser VARCHAR(240) NOT NULL,
    archived BOOLEAN NOT NULL DEFAULT false,
    important BOOLEAN NOT NULL DEFAULT false,
    priority VARCHAR(8) NOT NULL DEFAULT 'low' CHECK (priority IN ('low', 'medium', 'hight', 'urgent')),
    category VARCHAR(18) NOT NULL DEFAULT 'other' CHECK (category IN ('technical_support', 'bug',
    'billing_inquiry', 'feature_request', 'general_inquiry', 'other')),
    status VARCHAR(12) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'in_progress', 'resolved', 'closed')),
    assigned_to uuid REFERENCES berli."agent"(id),
    resolution_notes TEXT,
    attachments VARCHAR(255)[], -- Example VALUES ('{"archivo1.pdf", "archivo2.png", "archivo3.docx"}')
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
)
