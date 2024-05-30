\c berli

-- Count rows in tables
CREATE OR REPLACE FUNCTION berli.count_rows_in_tables(schema_name text)
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
