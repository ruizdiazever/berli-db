\c berli
-- AUTO UPDATE "UDPATED_AT" OF USER
CREATE TRIGGER update_user_updated_at
BEFORE UPDATE ON core."user"
FOR EACH ROW EXECUTE PROCEDURE update_updated_at();
