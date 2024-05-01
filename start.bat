@echo off

cd "./crm-backend-consignado"
start /B yarn start

cd ..

cd "./crm-frontend-consignado"
start /B yarn start


