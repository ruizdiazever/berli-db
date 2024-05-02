\c berli
CREATE INDEX idx_company_email ON core."company"(email);
CREATE INDEX idx_staff_email ON core."staff"(email);
CREATE INDEX idx_client_email ON core."client"(email);
CREATE INDEX idx_employee_email ON core."employee"(email);
