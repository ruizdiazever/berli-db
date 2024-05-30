\c berli

-- Get ENTITY with ID
CREATE OR REPLACE FUNCTION berli.get_user_with_id(p_id uuid)
RETURNS TABLE(schema_table text, id uuid, email text) AS $$
BEGIN
    RETURN QUERY
    SELECT 'berli.agent' as schema_table, berli.agent.id, berli.agent.email::text FROM berli.agent WHERE berli.agent.id = p_id
    UNION ALL
    SELECT 'users.company' as schema_table, users.company.id, users.company.email::text FROM users.company WHERE users.company.id = p_id
    UNION ALL
    SELECT 'users.staff' as schema_table, users.staff.id, users.staff.email::text FROM users.staff WHERE users.staff.id = p_id
    UNION ALL
    SELECT 'users.client' as schema_table, users.client.id, users.client.email::text FROM users.client WHERE users.client.id = p_id
    UNION ALL
    SELECT 'users.employee' as schema_table, users.employee.id, users.employee.email::text FROM users.employee WHERE users.employee.id = p_id;
END; $$ LANGUAGE plpgsql;


-- Get ENTITY with EMAIL
CREATE OR REPLACE FUNCTION berli.get_user_with_email(p_email text)
RETURNS TABLE(schema_table text, id uuid, email text) AS $$
BEGIN
    RETURN QUERY
    SELECT 'berli.agent' as schema_table, berli.agent.id, berli.agent.email::text FROM berli.agent WHERE berli.agent.email = p_email
    UNION ALL
    SELECT 'users.company' as schema_table, users.company.id, users.company.email::text FROM users.company WHERE users.company.email = p_email
    UNION ALL
    SELECT 'users.staff' as schema_table, users.staff.id, users.staff.email::text FROM users.staff WHERE users.staff.email = p_email
    UNION ALL
    SELECT 'users.client' as schema_table, users.client.id, users.client.email::text FROM users.client WHERE users.client.email = p_email
    UNION ALL
    SELECT 'users.employee' as schema_table, users.employee.id, users.employee.email::text FROM users.employee WHERE users.employee.email = p_email;
END; $$ LANGUAGE plpgsql;


-- Get COMPANY_ID with ID
CREATE OR REPLACE FUNCTION berli.get_company_id(p_id uuid)
RETURNS TABLE(company_id uuid) AS $$
BEGIN
    RETURN QUERY
    SELECT users.staff.company_id FROM users.staff WHERE users.staff.company_id = p_id
    UNION ALL
    SELECT users.client.company_id FROM users.client WHERE users.client.company_id = p_id
    UNION ALL
    SELECT users.employee.company_id FROM users.employee WHERE users.employee.company_id = p_id;
END; $$ LANGUAGE plpgsql;
