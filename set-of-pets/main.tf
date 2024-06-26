# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
  }
}


variable "max" {
  type    = number
  default = 10

  # validation {
  #   condition     = var.max > 0
  #   error_message = "The value must be greater than 0."
  # }
}

resource "random_integer" "this" {
  min = 1
  max = var.max
}


output "value" {
  value = random_integer.this.result
}
