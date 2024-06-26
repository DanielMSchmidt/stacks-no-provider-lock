# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0
terraform {
  required_providers {
    tfcoremock = {
      source  = "hashicorp/tfcoremock"
      version = "0.2.0"
    }
  }
}

resource "tfcoremock_simple_resource" "simple_resource" {
  id = "my-simple-resource2"
}
