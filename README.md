# Getting Started with Docker

### Prerequisites

* Docker
* docker-compose

### Run on docker

First time run build project

```bash
$ docker-compose up -d --build
```

app

```bash
$ docker-compose exec app bash
$ bundle install
$ bin/rails db:create
$ bin/rails db:create RAILS_ENV=test
$ bin/rails db:migrate
$ bin/rails db:migrate RAILS_ENV=test
$ bin/rails db:seed_fu
```

Start development server

```bash
$ docker-compose exec app bash
$ bin/rails s -b 0.0.0.0
```

Rspec

```bash
$ docker-compose exec app bash
$ bundle exec rspec
```

AnnotateRb ※Run modified `config/routes.rb`

```bash
$ docker-compose exec app bash
$ bundle exec annotaterb routes
```

### API

* docs/openapi.yaml
