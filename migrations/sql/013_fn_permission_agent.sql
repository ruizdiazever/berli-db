\c berli

-- Asign permission to AGENT
CREATE OR REPLACE FUNCTION permissions.assign_permissions_to_agent() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.role = 'admin' THEN
        INSERT INTO permissions."system_agent" (
            -- ID
            agent_id,
            -- SELF_UPDATE
            can_self_update,
            -- CREATION
            can_create_agent, can_create_company, can_create_client, can_create_staff, can_create_employee, can_create_project,
            -- REMOVE
            can_remove_agent, can_remove_company, can_remove_client, can_remove_staff, can_remove_employee, can_remove_project,
            -- EDIT
            can_edit_agent, can_edit_company, can_edit_client, can_edit_staff, can_edit_employee, can_edit_calendar, can_edit_project,
            -- GRANT AND REVOKE
            can_grant, can_revoke,
            -- UPLOAD
            can_upload_hours, can_upload_docs
        )
        VALUES (
            NEW.id,
            true,
            true, true, true, true, true, true,
            true, true, true, true, true, true,
            true, true, true, true, true, true, true,
            true, true,
            true, true
        );
    ELSIF NEW.role = 'managment' THEN
        INSERT INTO permissions."system_agent" (
        -- ID
        agent_id,
        -- CREATION
        can_create_company, can_create_client, can_create_staff, can_create_employee,
        -- REMOVE
        can_remove_company, can_remove_client, can_remove_staff, can_remove_employee,
        -- EDIT
        can_edit_company, can_edit_client, can_edit_staff, can_edit_employee, can_edit_calendar,
        -- GRANT AND REVOKE
        can_grant, can_revoke,
        -- UPLOAD
        can_upload_hours, can_upload_docs
    )
    VALUES (
        NEW.id,
        true, true, true, true,
        true, true, true, true,
        true, true, true, true, true,
        true, true,
        true, true
    );
    ELSIF NEW.role = 'support' THEN
        INSERT INTO permissions."system_agent" (
        -- ID
        agent_id,
        -- CREATION
        can_create_company, can_create_client, can_create_staff, can_create_employee,
        -- REMOVE
        can_remove_client, can_remove_staff, can_remove_employee,
        -- EDIT
        can_edit_company, can_edit_client, can_edit_staff, can_edit_employee, can_edit_calendar,
        -- GRANT AND REVOKE
        can_grant, can_revoke,
        -- UPLOAD
        can_upload_hours, can_upload_docs
    )
    VALUES (
        NEW.id,
        true, true, true, true,
        true, true, true,
        true, true, true, true, true,
        true, true,
        true, true
    );
    ELSIF NEW.role = 'sales' THEN
        INSERT INTO permissions."system_agent" (
        -- ID
        agent_id,
        -- CREATION
        can_create_company, can_create_client, can_create_staff, can_create_employee,
        -- REMOVE
        can_remove_client, can_remove_staff, can_remove_employee,
        -- EDIT
        can_edit_agent, can_edit_company, can_edit_client, can_edit_staff, can_edit_employee, can_edit_calendar,
        -- GRANT AND REVOKE
        can_grant, can_revoke,
        -- UPLOAD
        can_upload_hours, can_upload_docs
    )
    VALUES (
        NEW.id,
        true, true, true, true,
        true, true, true,
        true, true, true, true, true, true,
        true, true,
        true, true
    );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create agent permissions when a AGENT was created
CREATE TRIGGER after_agent_insert
AFTER INSERT ON berli."agent"
FOR EACH ROW
EXECUTE FUNCTION permissions.assign_permissions_to_agent();
