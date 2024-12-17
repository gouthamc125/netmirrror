#Using the Nodejs base image
FROM node:14-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

RUN npx browserslist@latest --update-db

COPY . .

RUN npm run build

#Using Nginx base image

FROM nginx:1.25-alpine

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
