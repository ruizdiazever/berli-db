\c berli

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
    FOREIGN KEY (client_id) REFERENCES users."client"(id)
);

-- PROJECT EMPLOYEE
CREATE TABLE projects."project_employee" (
    project_id uuid NOT NULL,
    employee_id uuid NOT NULL,
    PRIMARY KEY (project_id, employee_id),
    FOREIGN KEY (project_id) REFERENCES projects."project"(id),
    FOREIGN KEY (employee_id) REFERENCES users."employee"(id)
);
