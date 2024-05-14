\c berli
-- COUNT ROWS IN TABLES
CREATE OR REPLACE FUNCTION count_rows_in_tables(schema_name text)
RETURNS TABLE(table_name text, row_count bigint) AS $$
DECLARE
    table_name text;
BEGIN
    FOR table_name IN
        SELECT tablename FROM pg_tables WHERE schemaname = schema_name
    LOOP
        RETURN QUERY EXECUTE format('SELECT %s, COUNT(*) FROM %s.%s',
            quote_literal(table_name),
            quote_ident(schema_name),
            quote_ident(table_name));
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- ASSIGN RANDOM AVATAR
CREATE OR REPLACE FUNCTION assign_random_avatar()
RETURNS TRIGGER AS $$
BEGIN
    NEW.avatar_id := (
        SELECT id FROM users."avatar"
        OFFSET floor(random() * (SELECT count(*) FROM users."avatar"))
        LIMIT 1
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- UPDATE UPDATED_AT
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- GET USER WITH ID
CREATE OR REPLACE FUNCTION get_user_info(p_id uuid)
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

-- GET COMPANY_ID WITH ID
CREATE OR REPLACE FUNCTION get_company_id(p_id uuid)
RETURNS TABLE(company_id uuid) AS $$
BEGIN
    RETURN QUERY
    SELECT users.staff.company_id FROM users.staff WHERE users.staff.company_id = p_id
    UNION ALL
    SELECT users.client.company_id FROM users.client WHERE users.client.company_id = p_id
    UNION ALL
    SELECT users.employee.company_id FROM users.employee WHERE users.employee.company_id = p_id;
END; $$ LANGUAGE plpgsql;
