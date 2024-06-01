\c berli

-- Asign permission to COMPANY
CREATE OR REPLACE FUNCTION permissions.assign_permissions_to_employee() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO permissions."system_employee" (
        entity_id
    )
    VALUES (
        NEW.id
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Create agent permissions when a COMPANY was created
CREATE TRIGGER after_company_insert
AFTER INSERT ON users."employee"
FOR EACH ROW
EXECUTE FUNCTION permissions.assign_permissions_to_employee();
