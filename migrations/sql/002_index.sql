\c berli
CREATE INDEX idx_company_email ON users."company"(email);
CREATE INDEX idx_staff_email ON users."staff"(email);
CREATE INDEX idx_client_email ON users."client"(email);
CREATE INDEX idx_employee_email ON users."employee"(email);
