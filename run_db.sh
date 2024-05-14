sudo docker build -t berli_db .
sudo docker run -p 5433:5432 -d berli_db
