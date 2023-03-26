storage "raft" {
  path    = "./data"
  node_id = "node1"
}

listener "tcp" {
  address     = "127.0.0.1:8200" # server listener port
  tls_disable = "true"
}

api_addr = "http://127.0.0.1:8200" # address to advertise to route client requests.
cluster_addr = "https://127.0.0.1:8201" # the address and port to be used for communication between the Vault nodes in a cluster.
ui = true