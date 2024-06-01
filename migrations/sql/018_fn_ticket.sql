\c berli

-- Asign a ticket support to agent with less tickets
CREATE OR REPLACE FUNCTION support.assign_least_busy_support_agent() RETURNS TRIGGER AS $$
DECLARE
    least_busy_agent uuid;
BEGIN
    SELECT id INTO least_busy_agent
    FROM berli.agent
    WHERE role = 'support'
    ORDER BY (
        SELECT COUNT(*)
        FROM support.generic
        WHERE assigned_to = berli.agent.id
    )
    LIMIT 1;

    NEW.assigned_to = least_busy_agent;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Asign a ticket support to AGENT of type SUPPORT with less tickets
CREATE TRIGGER before_generic_insert
BEFORE INSERT ON support."generic"
FOR EACH ROW
EXECUTE FUNCTION support.assign_least_busy_support_agent();
