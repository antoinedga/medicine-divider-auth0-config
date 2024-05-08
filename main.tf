terraform {
  required_providers {
    auth0 = {
      source = "auth0/auth0"
      version = "1.2.0"
    }
  }
}

provider "auth0" {
  domain = var.auth0_domain
  client_id = var.auth0_client_id
  client_secret = var.auth0_client_secret
}

resource "auth0_action" "account-creation-signup" {
  name        = "account-creation-signup"
  code  = file("./src/actions/account-creation-signup.js")
  runtime = "node18"
  deploy = true

  dependencies {
    name    = "axios"
    version = "latest"
  }

  supported_triggers {
    id      = "post-user-registration"
    version = "v2"
  }
  secrets {
    name  = "BACKEND_SIGNUP_CALLBACK"
    value = var.backend_signup_callback
  }
}


resource "auth0_trigger_action" "post_login_alert_action" {
  trigger   = "post-user-registration"
  action_id = auth0_action.account-creation-signup.id
}