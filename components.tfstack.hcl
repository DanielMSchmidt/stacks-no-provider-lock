# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "prefix" {
  type = string
}

variable "instances" {
  type = number
}

required_providers {
  random = {
    source  = "hashicorp/random"
    version = "= 3.3.2"
  }

  null = {
    source  = "hashicorp/null"
    version = "~> 3.1.1"
  }

  tfcoremock = {
    source  = "hashicorp/tfcoremock"
    version = "0.2.0"
  }
}

provider "random" "this" {}
provider "null" "this" {}
provider "tfcoremock" "this" {}

component "pet" {
  source = "./pet"

  inputs = {
    prefix = var.prefix
  }

  providers = {
    random = provider.random.this
  }
}

component "nulls" {
  source = "./nulls"

  inputs = {
    pet       = component.pet.name
    instances = var.instances
  }

  providers = {
    null = provider.null.this
  }
}

component "mocks" {
    source = "./mocks"
    providers = {
        tfcoremock = provider.tfcoremock.this
    }
}

## A way to get deferred changes
component "diceroll" {
  source = "./set-of-pets"

  inputs = {
    max = 6
  }

  providers = {
    random = provider.random.this
  }
}

component "petperdice" {
  source = "./pet"

  inputs = {
    prefix = component.diceroll.value
  }

  providers = {
    random = provider.random.this
  }
}
