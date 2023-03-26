path "secrets/+/my-secret" {
    capabilities = ["read","list", "update"]
}

path "secrets/+/" {
    capabilities = ["list"]
}