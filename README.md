# Start local test server
vault server -config=config.hcl

# Setup the cluster
0 - Using the vault cli:
```
export VAULT_ADDR='http://127.0.0.1:8200'
```
1 - Initialize the cluster for the first time:
```
vault operator init
```
1.1 - Save the 5 Unseal Keys somewhere safe
1.2 - Save the Root Token somewhere safe

Example:
```
Unseal Key 1: 9FDnwdK6QE0NkN3Z7tgnSKe2JnrkHfPEVuivMtTWfKQy
Unseal Key 2: 1uYGUVEtfyqX3vZjFH8j56iHqQzZrK+9ZuvNfu4Bb1t+
Unseal Key 3: i0ac0NX23RAk4EAYLDDnKlyKsw34JKddygdadPbGxVEj
Unseal Key 4: 04vVKz5J/y5NPjXNA1l4LuixThT9r2JsKN67RP0p0iEK
Unseal Key 5: 8yIsFBesp4vaxJVoVkPpASq7avwsDQOOA0Q6FCvxSZoE
```

Initial Root Token: hvs.WGdQ4Sd14QQgQKr0MR51B7xB

```
export VAULT_TOKEN=hvs.WGdQ4Sd14QQgQKr0MR51B7xB
```

1 - Unseal the cluster:
```
vault operator unseal
<type at least 3 of 5 Unseal Key>
```

2 - Check the status
```
vault status
```
Should display "Sealed: false"

3 - Whe you need to login as Root
```
vault login
<type the Root Token>
```

# Setup Secrets Engines
## Setup key/value v2 Engine
1 - Run the command to enable:
```
vault secrets enable -path secrets -version=2 kv
```
It's going to enable the KV engine at "secrets/" path.

2 - Verify using:
```
vault secrets list
```
3 - Create a secret
```
vault kv put -mount=secrets my-key message=hello
```
4 - Update a secret
```
vault kv patch -mount=secrets my-key foo=world
```
5 - Get a secret
```
vault kv get -mount=secrets my-key
```
6 - Delete a secret
```
vault kv delete -mount=secrets my-key
```

# Setup Auth Methods
## Userpass
1 - Enable Auth method:
```
vault auth enable userpass
vault auth tune -default-lease-ttl=600 -max-lease-ttl=3600 userpass
```
2 - Create a new user:
```
vault write auth/userpass/users/john password=john policies=default
```
3 - Read users:
```
vault read auth/userpass/users/john
vault list auth/userpass/users
```
4 - Login using userpass:
```
vault login -method=userpass -path=userpass username=john
<type password>
```

# Setup Policy
Create:
```
vault policy write my-policy my-policy.hcl
```
Read:
```
vault policy read my-policy
vault policy list
```
Delete:
```
vault policy delete
```
