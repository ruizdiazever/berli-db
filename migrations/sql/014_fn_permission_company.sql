\c berli

-- Asign permission to COMPANY
CREATE OR REPLACE FUNCTION permissions.assign_permissions_to_company() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO permissions."system_entity" (
        entity_id,
        can_self_update,
        can_create_client, can_create_staff, can_create_employee, can_create_project,
        can_remove_client, can_remove_staff, can_remove_employee, can_remove_project,
        can_edit_client, can_edit_staff, can_edit_employee, can_edit_calendar, can_edit_project,
        can_grant, can_revoke,
        can_upload_hours, can_upload_docs
    )
    VALUES (
        NEW.id,
        true,
        true, true, true, true,
        true, true, true, true,
        true, true, true, true, true,
        true, true,
        true, true
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Create agent permissions when a COMPANY was created
CREATE TRIGGER after_company_insert
AFTER INSERT ON users."company"
FOR EACH ROW
EXECUTE FUNCTION permissions.assign_permissions_to_company();
