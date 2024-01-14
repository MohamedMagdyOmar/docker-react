FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build -> this the folder that we will cpoy during 'run phase'

FROM nginx
#copy build folder from previous builder phase - then folder that we want to copy to here nginx
COPY --from=builder /app/build /usr/share/nginx/html

# the run command will run automatically, no need to specify it