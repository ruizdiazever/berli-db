\c berli

-- FUNCTION UPDATED_AT OF TABLES
CREATE OR REPLACE FUNCTION berli.update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- AGENT
CREATE TRIGGER update_berli_updated_at
BEFORE UPDATE ON berli."agent"
FOR EACH ROW EXECUTE PROCEDURE berli.update_updated_at();

-- COMPANY
CREATE TRIGGER update_company_updated_at
BEFORE UPDATE ON users."company"
FOR EACH ROW EXECUTE PROCEDURE berli.update_updated_at();

-- STAFF
CREATE TRIGGER update_staff_updated_at
BEFORE UPDATE ON users."staff"
FOR EACH ROW EXECUTE PROCEDURE berli.update_updated_at();

-- CLIENT
CREATE TRIGGER update_client_updated_at
BEFORE UPDATE ON users."client"
FOR EACH ROW EXECUTE PROCEDURE berli.update_updated_at();

-- EMPLOYEE
CREATE TRIGGER update_employee_updated_at
BEFORE UPDATE ON users."employee"
FOR EACH ROW EXECUTE PROCEDURE berli.update_updated_at();
