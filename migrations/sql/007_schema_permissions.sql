-- DB
\c berli

-- AGENT
CREATE TABLE permissions."system_agent" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT permissions_agent_pkey PRIMARY KEY,
    agent_id uuid NOT NULL,
    -- SELF_UPDATE
    can_self_update BOOLEAN NOT NULL DEFAULT false, -- admin
    -- CREATION
    agent BOOLEAN NOT NULL DEFAULT false, -- admin
    can_create_company BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    can_create_client BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    can_create_staff BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    can_create_employee BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    can_create_project BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    -- REMOVE
    can_remove_agent BOOLEAN NOT NULL DEFAULT false, -- admin
    can_remove_company BOOLEAN NOT NULL DEFAULT false, -- admin, managment
    can_remove_client BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    can_remove_staff BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    can_remove_employee BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    can_remove_project BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    -- EDIT
    can_edit_agent BOOLEAN NOT NULL DEFAULT false,
    can_edit_company BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    can_edit_client BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    can_edit_staff BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    can_edit_employee BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    can_edit_calendar BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    can_edit_project BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    -- GRANT AND REVOKE
    can_grant BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    can_revoke BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    -- UPLOAD
    can_upload_hours BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    can_upload_docs BOOLEAN NOT NULL DEFAULT false, -- admin, managment, sales, support
    FOREIGN KEY (agent_id) REFERENCES berli."agent"(id)
);

-- SYSTEM PERMISSION TO COMPANY
CREATE TABLE permissions."system_company" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT permissions_system_company_pkey PRIMARY KEY,
    entity_id uuid NOT NULL UNIQUE,
    -- SELF_UPDATE
    can_self_update BOOLEAN NOT NULL DEFAULT true,
    -- CREATION
    can_create_client BOOLEAN NOT NULL DEFAULT true,
    can_create_staff BOOLEAN NOT NULL DEFAULT true,
    can_create_employee BOOLEAN NOT NULL DEFAULT true,
    can_create_project BOOLEAN NOT NULL DEFAULT true,
    -- REMOVE
    can_remove_client BOOLEAN NOT NULL DEFAULT true,
    can_remove_staff BOOLEAN NOT NULL DEFAULT true,
    can_remove_employee BOOLEAN NOT NULL DEFAULT true,
    can_remove_project BOOLEAN NOT NULL DEFAULT true,
    -- EDIT
    can_edit_client BOOLEAN NOT NULL DEFAULT true,
    can_edit_staff BOOLEAN NOT NULL DEFAULT true,
    can_edit_employee BOOLEAN NOT NULL DEFAULT true,
    can_edit_calendar BOOLEAN NOT NULL DEFAULT true,
    can_edit_project BOOLEAN NOT NULL DEFAULT true,
    -- GRANT AND REVOKE
    can_grant BOOLEAN NOT NULL DEFAULT true,
    can_revoke BOOLEAN NOT NULL DEFAULT true,
    -- UPLOAD
    can_upload_hours BOOLEAN NOT NULL DEFAULT true,
    can_upload_docs BOOLEAN NOT NULL DEFAULT true,
    -- INFO
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- SYSTEM PERMISSION TO STAFF
CREATE TABLE permissions."system_staff" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT permissions_system_staff_pkey PRIMARY KEY,
    entity_id uuid NOT NULL UNIQUE,
    -- SELF_UPDATE
    can_self_update BOOLEAN NOT NULL DEFAULT false,
    -- CREATION
    can_create_client BOOLEAN NOT NULL DEFAULT false,
    can_create_staff BOOLEAN NOT NULL DEFAULT false,
    can_create_employee BOOLEAN NOT NULL DEFAULT false,
    can_create_project BOOLEAN NOT NULL DEFAULT false,
    -- REMOVE
    can_remove_client BOOLEAN NOT NULL DEFAULT false,
    can_remove_staff BOOLEAN NOT NULL DEFAULT false,
    can_remove_employee BOOLEAN NOT NULL DEFAULT false,
    can_remove_project BOOLEAN NOT NULL DEFAULT false,
    -- EDIT
    can_edit_client BOOLEAN NOT NULL DEFAULT false,
    can_edit_staff BOOLEAN NOT NULL DEFAULT false,
    can_edit_employee BOOLEAN NOT NULL DEFAULT false,
    can_edit_calendar BOOLEAN NOT NULL DEFAULT false,
    can_edit_project BOOLEAN NOT NULL DEFAULT false,
    -- GRANT AND REVOKE
    can_grant BOOLEAN NOT NULL DEFAULT false,
    can_revoke BOOLEAN NOT NULL DEFAULT false,
    -- UPLOAD
    can_upload_hours BOOLEAN NOT NULL DEFAULT false,
    can_upload_docs BOOLEAN NOT NULL DEFAULT false,
    -- INFO
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- SYSTEM PERMISSION TO CLIENT
CREATE TABLE permissions."system_client" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT permissions_system_client_pkey PRIMARY KEY,
    entity_id uuid NOT NULL UNIQUE,
    -- SELF_UPDATE
    can_self_update BOOLEAN NOT NULL DEFAULT false,
    -- CREATION
    can_create_employee BOOLEAN NOT NULL DEFAULT false,
    can_create_project BOOLEAN NOT NULL DEFAULT false,
    -- REMOVE
    can_remove_project BOOLEAN NOT NULL DEFAULT false,
    -- EDIT
    can_edit_employee BOOLEAN NOT NULL DEFAULT false,
    can_edit_calendar BOOLEAN NOT NULL DEFAULT false,
    can_edit_project BOOLEAN NOT NULL DEFAULT false,
    -- GRANT AND REVOKE
    can_grant BOOLEAN NOT NULL DEFAULT false,
    can_revoke BOOLEAN NOT NULL DEFAULT false,
    -- UPLOAD
    can_upload_hours BOOLEAN NOT NULL DEFAULT false,
    can_upload_docs BOOLEAN NOT NULL DEFAULT false,
    -- INFO
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- SYSTEM PERMISSION TO EMPLOYEE
CREATE TABLE permissions."system_employee" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT permissions_system_employee_pkey PRIMARY KEY,
    entity_id uuid NOT NULL UNIQUE,
    -- EDIT
    can_edit_calendar BOOLEAN NOT NULL DEFAULT false,
    -- UPLOAD
    can_upload_hours BOOLEAN NOT NULL DEFAULT false,
    can_upload_docs BOOLEAN NOT NULL DEFAULT false,
    -- INFO
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- FILE
CREATE TABLE permissions."file" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL CONSTRAINT permissions_file_pkey PRIMARY KEY
);

-- FILE PERMISSIONS
CREATE TABLE permissions."file_permissions" (
    file_id uuid NOT NULL,
    entity_id uuid NOT NULL UNIQUE,
    can_view BOOLEAN DEFAULT false,
    can_update BOOLEAN DEFAULT false,
    can_download BOOLEAN DEFAULT false,
    can_remove BOOLEAN DEFAULT false,
    CONSTRAINT file_permissions_pkey PRIMARY KEY (file_id, entity_id),
    FOREIGN KEY (file_id) REFERENCES permissions."file"(id)
);

-- COMMUNICATION
CREATE TABLE permissions."communication" (
    id uuid DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
    entity_id uuid NOT NULL UNIQUE,
    communication BOOLEAN NOT NULL DEFAULT true,
    newsletter BOOLEAN NOT NULL DEFAULT false,
    announcements BOOLEAN NOT NULL DEFAULT false,
    research BOOLEAN NOT NULL DEFAULT false,
    token uuid DEFAULT uuid_generate_v4() NOT NULL UNIQUE,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);
