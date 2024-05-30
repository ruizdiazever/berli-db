\c berli

-- Assign random avatar
CREATE OR REPLACE FUNCTION berli.assign_random_avatar()
RETURNS TRIGGER AS $$
BEGIN
    NEW.avatar_id := (
        SELECT id FROM berli."avatar"
        OFFSET floor(random() * (SELECT count(*) FROM berli."avatar"))
        LIMIT 1
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- AGENT
CREATE TRIGGER trigger_assign_random_avatar
BEFORE INSERT ON berli."agent"
FOR EACH ROW
EXECUTE FUNCTION berli.assign_random_avatar();

-- COMPANY
CREATE TRIGGER trigger_assign_random_avatar
BEFORE INSERT ON users."company"
FOR EACH ROW
EXECUTE FUNCTION berli.assign_random_avatar();

-- STAFF
CREATE TRIGGER trigger_assign_random_avatar
BEFORE INSERT ON users."staff"
FOR EACH ROW
EXECUTE FUNCTION berli.assign_random_avatar();

-- CLIENT
CREATE TRIGGER trigger_assign_random_avatar
BEFORE INSERT ON users."client"
FOR EACH ROW
EXECUTE FUNCTION berli.assign_random_avatar();

-- EMPLOYEE
CREATE TRIGGER trigger_assign_random_avatar
BEFORE INSERT ON users."employee"
FOR EACH ROW
EXECUTE FUNCTION berli.assign_random_avatar();
