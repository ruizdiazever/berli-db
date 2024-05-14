\c berli

-- AUTO UPDATE "UDPATED_AT" OF AGENT
CREATE TRIGGER update_berli_updated_at
BEFORE UPDATE ON berli."agent"
FOR EACH ROW EXECUTE PROCEDURE update_updated_at();

-- RANDOM AVATAR AGENT
CREATE TRIGGER trigger_assign_random_avatar
BEFORE INSERT ON berli."agent"
FOR EACH ROW
EXECUTE FUNCTION assign_random_avatar();

-- AUTO UPDATE "UDPATED_AT" OF COMPANY
CREATE TRIGGER update_company_updated_at
BEFORE UPDATE ON users."company"
FOR EACH ROW EXECUTE PROCEDURE update_updated_at();

-- RANDOM AVATAR COMPANY
CREATE TRIGGER trigger_assign_random_avatar
BEFORE INSERT ON users."company"
FOR EACH ROW
EXECUTE FUNCTION assign_random_avatar();

-- AUTO UPDATE "UDPATED_AT" OF STAFF
CREATE TRIGGER update_staff_updated_at
BEFORE UPDATE ON users."staff"
FOR EACH ROW EXECUTE PROCEDURE update_updated_at();

-- RANDOM AVATAR STAFF
CREATE TRIGGER trigger_assign_random_avatar
BEFORE INSERT ON users."staff"
FOR EACH ROW
EXECUTE FUNCTION assign_random_avatar();

-- AUTO UPDATE "UDPATED_AT" OF CLIENT
CREATE TRIGGER update_client_updated_at
BEFORE UPDATE ON users."client"
FOR EACH ROW EXECUTE PROCEDURE update_updated_at();

-- RANDOM AVATAR CLIENT
CREATE TRIGGER trigger_assign_random_avatar
BEFORE INSERT ON users."client"
FOR EACH ROW
EXECUTE FUNCTION assign_random_avatar();

-- AUTO UPDATE "UDPATED_AT" OF EMPLOYEE
CREATE TRIGGER update_employee_updated_at
BEFORE UPDATE ON users."employee"
FOR EACH ROW EXECUTE PROCEDURE update_updated_at();

-- RANDOM AVATAR EMPLOYEE
CREATE TRIGGER trigger_assign_random_avatar
BEFORE INSERT ON users."employee"
FOR EACH ROW
EXECUTE FUNCTION assign_random_avatar();
