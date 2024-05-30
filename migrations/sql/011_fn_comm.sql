\c berli

-- Communication creation when a entity was created
CREATE OR REPLACE FUNCTION support.create_communication()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO permissions.communication (entity_id)
    VALUES (NEW.id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- AGENT
CREATE TRIGGER after_user_insert
AFTER INSERT ON berli."agent"
FOR EACH ROW
EXECUTE FUNCTION support.create_communication();

-- COMPANY
CREATE TRIGGER after_user_insert
AFTER INSERT ON users."company"
FOR EACH ROW
EXECUTE FUNCTION support.create_communication();

-- STAFF
CREATE TRIGGER after_user_insert
AFTER INSERT ON users."staff"
FOR EACH ROW
EXECUTE FUNCTION support.create_communication();

-- CLIENT
CREATE TRIGGER after_user_insert
AFTER INSERT ON users."client"
FOR EACH ROW
EXECUTE FUNCTION support.create_communication();

-- EMPLOYEE
CREATE TRIGGER after_user_insert
AFTER INSERT ON users."employee"
FOR EACH ROW
EXECUTE FUNCTION support.create_communication();
