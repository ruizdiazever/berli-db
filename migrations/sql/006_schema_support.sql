-- DB
\c berli

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
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (entity_id) REFERENCES berli."agent"(id),
    FOREIGN KEY (entity_id) REFERENCES users."company"(id),
    FOREIGN KEY (entity_id) REFERENCES users."client"(id),
    FOREIGN KEY (entity_id) REFERENCES users."staff"(id),
    FOREIGN KEY (entity_id) REFERENCES users."employee"(id)
)
