# Basic Vault golden image
packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "alpine" {
  image  = "alpine:3.16"
  commit = true
}

build {
  name = "learn-packer"
  sources = [
    "source.docker.alpine"
  ]
  provisioner "shell" {
    environment_vars = [
      "FOO=hello world",
    ]
    inline = [
      "sleep 30",
      "apk update",
      "apk add unzip",
      "apk add curl",
      "curl -L https://releases.hashicorp.com/vault/1.13.1/vault_1.13.1_linux_arm64.zip -o vault.zip",
      "unzip vault.zip",
      "chown root:root vault",
      "mv vault /usr/local/bin",
      "rm -f vault.zip"
    ]
  }
}

