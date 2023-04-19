# FROM node:lts-alpine as build-stage
# WORKDIR /app
# ENV PORT 8080
# EXPOSE 8080
# COPY package*.json ./
# RUN npm install
# COPY . .
# CMD ["npm", "start"]


# FROM node:lts-alpine as build-stage
# WORKDIR /app
# ARG DB_URL
# ENV PORT 3002
# ENV DATABASE_URL ${DB_URL}
# COPY . .
# RUN npm install
# #RUN npx prisma migrate dev --name init
# RUN npx prisma migrate dev --name init --skip-seed
# RUN npm run build
# EXPOSE 3002

# CMD ["npm", "run", "start:prod"]



FROM node:14 as builder

# Create app directory
WORKDIR /app
ENV PORT 8080

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./
COPY prisma ./prisma/

# APP ARGS
ARG APP_ENV

# Install app dependencies
RUN npm install

COPY . .

RUN npm run build

FROM node:14

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/prisma ./prisma

EXPOSE 8080
# 👇 new migrate and start app script
CMD [  "npm", "run", "deploy" ]
