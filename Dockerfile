FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build -> this the folder that we will cpoy during 'run phase'

FROM nginx
EXPOSE 80
# when elastic bean stalk search for docker, it search for EXPORT key word inside your container to know that your application will recieve requests on port 80 
# copy build folder from previous builder phase - then folder that we want to copy to here nginx
COPY --from=builder /app/build /usr/share/nginx/html

# the run command will run automatically, no need to specify it