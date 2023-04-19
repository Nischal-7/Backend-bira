docker pull postgres
# NOTE THIS IS ONLY FOR LOCAL DEV DO NOT COMMIT OTHER ENVIRONMENT CREDENTIALS!!
docker run --name issue-tracker -p 5455:5432 -e POSTGRES_PASSWORD=hu2023 -d postgres

sleep 10

npm i

npx prisma migrate dev --name init

npm start