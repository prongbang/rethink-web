FROM node:9.5.0-alpine as builder

RUN mkdir -p /usr/src/rethink-web
WORKDIR /usr/src/rethink-web

ENV PATH /usr/src/rethink-web/node_modules/.bin:$PATH
ADD package.json /usr/src/rethink-web/package.json
RUN npm install --silent
RUN npm install react-scripts@1.1.0 -g --silent
ADD . /usr/src/rethink-web
RUN npm run build

# production environment
FROM nginx:1.13.5-alpine
COPY --from=builder /usr/src/rethink-web/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]