provider "heroku" {
  email   = "adrianpco@gmail.com"
  api_key = "${var.heroku_api_key}"
}

resource "heroku_app" "default" {
  name   = "the-bar"
  region = "us"

  config_vars {
    SECRET_KEY_BASE = "${var.secret_key_base}"
		NODE_ENV = "${var.node_env}"
  }
}

resource "heroku_addon" "database" {
  app  = "${heroku_app.default.name}"
  plan = "heroku-postgresql:hobby-dev"
}
