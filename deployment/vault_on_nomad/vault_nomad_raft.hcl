job "vault" {
  datacenters = ["dc1"]
  type        = "service"

  group "vault" {
    count = 1

    task "vault" {
      driver = "docker"

      config {
        image = "hashicorp/vault:latest"

        args = [
          "server",
          "-config=/local/vault.hcl"
        ]

        port_map {
          vault = 8200
          cluster = 8201
        }
      }

      env {
        VAULT_ADDR = "http://localhost:8200"
      }

      template {
        data = <<EOH
disable_mlock = "true"
storage "raft" {
  path = "/vault/file"
  node_id  = "raft_node_1"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = "true"
}

api_addr = "http://0.0.0.0:8200"
cluster_addr = "http://0.0.0.0:8201"
ui = true
EOH

        destination = "local/vault.hcl"
      }

      resources {
        cpu    = 500
        memory = 256

        network {
          mbits = 10
          port "vault" {}
          port "cluster" {}
        }
      }

      service {
        name = "vault"
        port = "vault"

        check {
          type     = "http"
          path     = "/v1/sys/health"
          interval = "10s"
          timeout  = "2s"
        }
      }

      service {
        name = "vault-cluster"
        port = "cluster"

        tags = ["non_http"]

        check {
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
