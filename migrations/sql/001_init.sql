-- DB
CREATE DATABASE berli;
\c berli

-- SCHEMAS
CREATE SCHEMA IF NOT EXISTS core;
SET search_path TO core;


-- UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
SELECT uuid_generate_v4();


-- COMPANY
CREATE TABLE core."company" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT company_pkey PRIMARY KEY,
    email VARCHAR(89) NOT NULL CONSTRAINT email_company_unique UNIQUE,
    avatar VARCHAR(120) DEFAULT 'std' NOT NULL,
    name VARCHAR(100) NOT NULL,
    industry VARCHAR(100) NOT NULL,
    adress_line VARCHAR(60) NOT NULL,
    city VARCHAR(30) NOT NULL,
    country VARCHAR(20) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);


-- STAFF
CREATE TABLE core."staff" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT staff_pkey PRIMARY KEY,
    email VARCHAR(89) NOT NULL CONSTRAINT email_staff_unique UNIQUE,
    company_id uuid NOT NULL,
    avatar VARCHAR(120) DEFAULT 'std' NOT NULL,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    contact VARCHAR(255),
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (company_id) REFERENCES core."company"(id)
);


-- CLIENT
CREATE TABLE core."client" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT staff_pkey PRIMARY KEY,
    email VARCHAR(89) NOT NULL CONSTRAINT email_client_unique UNIQUE,
    company_id uuid NOT NULL,
    avatar VARCHAR(120) DEFAULT 'std' NOT NULL,
    name VARCHAR(100) NOT NULL
    industry VARCHAR(100) NOT NULL,
    adress_line VARCHAR(60) NOT NULL,
    city VARCHAR(30) NOT NULL,
    country VARCHAR(20) NOT NULL,
    position VARCHAR(100) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (company_id) REFERENCES core."company"(id)
);


-- EMPLOYEE
CREATE TABLE core."employee" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT employee_pkey PRIMARY KEY,
    email VARCHAR(89) NOT NULL CONSTRAINT employee_client_unique UNIQUE,
    company_id uuid NOT NULL,
    client_id uuid NOT NULL,
    name VARCHAR(40) NOT NULL,
    lastname VARCHAR(40) NOT NULL,
    position VARCHAR(100) NOT NULL,
    contact VARCHAR(89),
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (company_id) REFERENCES core."company"(id),
    FOREIGN KEY (client_id) REFERENCES core."client"(id)
);


-- SESSION MAGIC LINK
CREATE TABLE IF NOT EXISTS core."entities_sessions_magic" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT magiclink_pkey PRIMARY KEY,
    user_id uuid NOT NULL UNIQUE,
    session_id VARCHAR NOT NULL,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES core."user"(id)
);

-- EMPLOYEE CALENDAR
CREATE TABLE core."employee_calendar" (
    calendar_id SERIAL PRIMARY KEY,
    employee_id uuid NOT NULL,
    date DATE NOT NULL,
    project_id uuid,
    hours_worked NUMERIC(10, 2) DEFAULT 0,
    description VARCHAR(100),
    FOREIGN KEY (employee_id) REFERENCES core."employee"(employee_id),
    FOREIGN KEY (project_id) REFERENCES core."project"(project_id)
);


-- ENTITIES PERMISSIONS
CREATE TABLE core."permissions" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT permissions_pkey PRIMARY KEY,
    company_id uuid NOT NULL,
    entity_type VARCHAR(20) NOT NULL CHECK (entity_type IN ('client', 'staff', 'employee')),
    entity_id uuid NOT NULL,
    can_grant BOOLEAN NOT NULL DEFAULT false, -- Indicates whether this entity can grant permissions
    can_revoke BOOLEAN NOT NULL DEFAULT false, -- Indicates whether this entity can revoke permits
    can_upload_hours BOOLEAN NOT NULL DEFAULT false,
    can_upload_docs BOOLEAN NOT NULL DEFAULT false,
    can_remove_docs BOOLEAN NOT NULL DEFAULT false,
    can_create_employee BOOLEAN NOT NULL DEFAULT false,
    can_edit_employee BOOLEAN NOT NULL DEFAULT false,
    can_edit_client BOOLEAN NOT NULL DEFAULT false,
    can_remove_employee BOOLEAN NOT NULL DEFAULT false,
    can_remove_client BOOLEAN NOT NULL DEFAULT false,
    can_modify_calendar BOOLEAN NOT NULL DEFAULT false,
    FOREIGN KEY (company_id) REFERENCES core."company"(id)
);


-- FILE PERMISSIONS
CREATE TABLE core."file_permissions" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT permissions_pkey PRIMARY KEY,
    company_id uuid NOT NULL,
    entity_type VARCHAR(20) NOT NULL CHECK (entity_type IN ('client', 'employee')),
    entity_id uuid NOT NULL,
    uploader_id uuid NOT NULL,
    can_view BOOLEAN DEFAULT false,
    can_download BOOLEAN DEFAULT false,
    FOREIGN KEY (company_id) REFERENCES core."company"(id)
);


-- SUPPORT CONTACT
CREATE TABLE core."support_contact" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    company_id uuid NOT NULL REFERENCES core."company"(id),
    email_input VARCHAR(89) NOT NULL,
    msg_input VARCHAR(240) NOT NULL,
    msg_dev VARCHAR(240) NOT NULL,
    archived BOOLEAN NOT NULL DEFAULT false,
    important BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);
