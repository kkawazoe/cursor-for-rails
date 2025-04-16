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
$ bundle exec rails db:create
$ bundle exec rails db:migrate
$ bundle exec rails db:migrate RAILS_ENV=test
$ bundle exec rails db:seed_fu
```

Start development server

```bash
$ docker-compose exec app bash
$ bundle exec rails s -b 0.0.0.0
```

Rspec

```bash
$ docker-compose exec app bash
$ bundle exec rspec
```

Annotate ※Run modified `config/routes.rb`

```bash
$ docker-compose exec app bash
$ bundle exec rake annotate_routes
```

### API

* docs/openapi.yaml
