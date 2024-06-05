\c berli
DO $$
DECLARE
    agent_id uuid;
    company_id_1 uuid;
    company_id_2 uuid;
    staff_id_1 uuid;
    client_id_1 uuid;
    client_id_2 uuid;
    employee_id_1 uuid;
    employee_id_2 uuid;
BEGIN
    -- Insert a BERLi agent
    INSERT INTO berli."agent" (email, name, lastname, role)
    VALUES (
        'ruizdiaz.oe@gmail.com', 'Ever', 'Ruiz Diaz', 'admin'
    )
    RETURNING id INTO agent_id;

    -- Insert company 1
    INSERT INTO users."company" (email, company_tax_id, pec, name, industry, contact, area_code,
    phone, address_line, zip_code, city, country)
    VALUES (
        'contact@berli.com', '149771007', 'berli@pec.it',
        'BERLi System', 'Software', 'administration@berli.it',
        '+39', '3280649202', 'Lungotevere Flaminio 44', '00196', 'Rome', 'Italy'
    )
    RETURNING id INTO company_id_1;

    -- Insert company 2
    INSERT INTO users."company" (email, company_tax_id, pec, name, industry, contact, area_code,
    phone, address_line, zip_code, city, country)
    VALUES (
        'amministrazione@eticalavoro.it', '149771007', 'eticalavorosrl@pec.it',
        'Etica Lavoro SRL', 'Agenzia per il lavoro', 'amministrazione@eticalavoro.it',
        '+39', '0640060357', 'Via Michele Mercati 38', 'CP00187', 'Rome', 'Italy'
    )
    RETURNING id INTO company_id_2;

    -- Insert a staff
    INSERT INTO users."staff" (email, company_id, iban, tax_id, national_id_card,
    name, lastname, position, contact, area_code, phone, address_line, zip_code, city, country)
    VALUES (
        'valentinadandria@gmail.com', company_id_1, 'IT78B0329401601000067173780', 'RZDVRL92T13Z610L',
        'CA21242JP', 'Valentina', 'dAndria', 'Subdirectora', 'valentinadandria@gmail.com',
        '+39', '3280649202', 'Lungotevere Flaminio 44', '00196', 'Rome', 'Italy'
    )
    RETURNING id INTO staff_id_1;

    -- Insert client 1
    INSERT INTO users."client" (email, company_id, company_tax_id, pec,
    name, industry, contact, area_code, phone, address_line, zip_code, city, country)
    VALUES (
        'ruizdiaz.oe@gmail.com', company_id_1, '115731027', 'aura@pec.it',
        'Aura Design', 'Design', 'ruizdiazever@icloud.com', '+39', '1126696100',
        'Lungotevere Flaminio 44', '00196', 'Rome', 'Italy'
    )
    RETURNING id INTO client_id_1;

    -- Insert client 2
    INSERT INTO users."client" (email, company_id, company_tax_id, pec,
    name, industry, contact, area_code, phone, address_line, zip_code, city, country)
    VALUES (
        'ruizdiaz.oe@gmail.com', company_id_1, '115731027', 'aura@pec.it',
        'Picu Industries', 'Engineering', 'ruizdiazever@icloud.com', '+39', '1126696100',
        'Lungotevere Flaminio 44', '00196', 'Rome', 'Italy'
    )
    RETURNING id INTO client_id_2;

    -- Insert a employee 1
    INSERT INTO users."employee" (email, company_id, client_id, iban, tax_id,
    national_id_card, name, lastname, position, contact, area_code, phone,
    address_line, zip_code, city, country)
    VALUES (
        'ruizdiazever@outlook.com', company_id_1, client_id_1, 'IT15B0329601601001067172780',
        'RZDVRL92T13Z610L', 'CA11242SP', 'Elon', 'Musk', 'Fisic', 'elon@spacex.com',
        '+54', '1126696100', 'Lungotevere Flaminio 44',  '00196', 'Rome', 'Italy'
    )
    RETURNING id INTO employee_id_1;

    -- Insert a employee 2
    INSERT INTO users."employee" (email, company_id, client_id, iban, tax_id,
    national_id_card, name, lastname, position, contact,
    area_code, phone, address_line, zip_code, city,
    country)
    VALUES (
        'acme@acme.com', company_id_1, client_id_1, 'IT15B0329601601001167172790', 'RZDVRL92T13Z611L',
        'CA11232SP', 'Pepito', 'Perez', 'Developer', 'acme@acme.com',
        '+54', '1122696100', 'Lungotevere Flaminio 44',  '00196', 'Rome',
        'Italy'
    )
    RETURNING id INTO employee_id_2;
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Error: %', SQLERRM;
END $$;
