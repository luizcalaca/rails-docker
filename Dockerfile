version: '3'
services:
  db:
    image: postgres
    ports:
      - "5432"

  web:
    build: .
    command: bundle exec rails s -p 3000 -b '0.0.0.0'
    volumes:
      - .:/your-application
    ports:
      - "3000:3000"
    depends_on:
      - db


  redis:
    image: redis:3.2-alpine
    command: redis-server --port 7479
    ports:
      - "7479:7479"

  sidekiq:
    build: .
    command: bundle exec sidekiq
    depends_on:
      - db
      - redis
