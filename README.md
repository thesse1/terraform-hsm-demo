### Demo for setting up HSM key transfer scenario with Terraform

This repository includes the Terraform configuration for setting up a demo for transfering HSM backed keys from IBM Hyper Protect Crypto Services (HPCS) to Azure Key Vault - Bring Your Own Key (BYOK) scenario. It consists of:
- Two Azure Key Vault (Premium Plan) instances in two different regions (Germany West Central and West Europe)
- An IBM Hyper Protect Crypto Services with Unified Key Orchestrator instance configured with a vault containing:
  - Two keystores of type Azure Key Vault pointing at the two Azure Key Vault instances
  - A key template referencing the two keystores
  - Two keys created using the key template, each one activated on both keystores

In both Azure Key Vault instances, the HSM key transfer creates three keys:
- The "EKMF-BYOK-KEK-FOR-IMPORT" key used for the BYOK mechanism
- The two keys managed in HPCS

<img width="2525" height="658" alt="image" src="https://github.com/user-attachments/assets/6c920cc1-c313-49d4-8d4e-5b28762d636a" />

<img width="2511" height="530" alt="image" src="https://github.com/user-attachments/assets/63ffbbbf-c395-49af-9249-d06ba58239c9" />

<img width="2512" height="521" alt="image" src="https://github.com/user-attachments/assets/0148db36-b084-418b-af87-f153ecbb4624" />

<img width="1321" height="510" alt="image" src="https://github.com/user-attachments/assets/23a4960f-a219-4c46-8451-695c92df4e47" />

<img width="1325" height="510" alt="image" src="https://github.com/user-attachments/assets/48832960-8488-4973-ac8d-02d85334088f" />

After creating the resources, Terraform reads and outputs the public data of the four keys created in the two key vaults. Comparing the public keys proves that identical keys were created in both key vaults:

```
azure_keys_germanywestcentral = [
  {
    "curve" = ""
    "e" = "AQAB"
    "id" = "https://thes-kv-germanywestcentr.vault.azure.net/keys/thes-key-1/67a217a40a614b218df2dfd448b66d75"
    "key_opts" = tolist([
      "encrypt",
      "decrypt",
      "wrapKey",
      "unwrapKey",
      "sign",
      "verify",
    ])
    "key_size" = tonumber(null)
    "key_type" = "RSA-HSM"
    "key_vault_id" = "/subscriptions/ff31b71c-d9b7-4f2e-ae63-fe2e02acdfe1/resourceGroups/thes-hsm/providers/Microsoft.KeyVault/vaults/thes-kv-germanywestcentr"
    "n" = "qeVB_DgC2XKBEgI6IQpUZ_JRbidDzOVbnHL1RFo7EUuFuiS4dsQ_tuz0Dg7KLvabeM1v41DkFHiqh6KKPLQS1n-FA_EIYWGjZtVMAdvjWKQkDy5jIZjxsKra_KtF8yD75qV125dCo7Seeje9pKCjxm3Ut7ZDjPO51PE2ix2wnLh5i7342ugWpvV6pQYha1Q6i_eXDNveaUuG-WsTsb1i5pTxv-oJ-x9LKdUzCe1Nq4GNPIZug4rcxfd70XjZdWAWlWr4FlZ1Z67zpCpSkDbsm6AkNEKgMh9EPJfNqxAD3W9fZC3WeWyczEcBnuVTKg3-c_z4Hihh8rU0dwsr2clA0w"
    "name" = "thes-key-1"
    "public_key_openssh" = <<-EOT
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCp5UH8OALZcoESAjohClRn8lFuJ0PM5VuccvVEWjsRS4W6JLh2xD+27PQODsou9pt4zW/jUOQUeKqHooo8tBLWf4UD8QhhYaNm1UwB2+NYpCQPLmMhmPGwqtr8q0XzIPvmpXXbl0KjtJ56N72koKPGbdS3tkOM87nU8TaLHbCcuHmLvfja6Bam9XqlBiFrVDqL95cM295pS4b5axOxvWLmlPG/6gn7H0sp1TMJ7U2rgY08hm6DitzF93vReNl1YBaVavgWVnVnrvOkKlKQNuyboCQ0QqAyH0Q8l82rEAPdb19kLdZ5bJzMRwGe5VMqDf5z/PgeKGHytTR3CyvZyUDT

    EOT
    "public_key_pem" = <<-EOT
    -----BEGIN PUBLIC KEY-----
    MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqeVB/DgC2XKBEgI6IQpU
    Z/JRbidDzOVbnHL1RFo7EUuFuiS4dsQ/tuz0Dg7KLvabeM1v41DkFHiqh6KKPLQS
    1n+FA/EIYWGjZtVMAdvjWKQkDy5jIZjxsKra/KtF8yD75qV125dCo7Seeje9pKCj
    xm3Ut7ZDjPO51PE2ix2wnLh5i7342ugWpvV6pQYha1Q6i/eXDNveaUuG+WsTsb1i
    5pTxv+oJ+x9LKdUzCe1Nq4GNPIZug4rcxfd70XjZdWAWlWr4FlZ1Z67zpCpSkDbs
    m6AkNEKgMh9EPJfNqxAD3W9fZC3WeWyczEcBnuVTKg3+c/z4Hihh8rU0dwsr2clA
    0wIDAQAB
    -----END PUBLIC KEY-----

    EOT
    "resource_id" = "/subscriptions/ff31b71c-d9b7-4f2e-ae63-fe2e02acdfe1/resourceGroups/thes-hsm/providers/Microsoft.KeyVault/vaults/thes-kv-germanywestcentr/keys/thes-key-1/versions/67a217a40a614b218df2dfd448b66d75"
    "resource_versionless_id" = "/subscriptions/ff31b71c-d9b7-4f2e-ae63-fe2e02acdfe1/resourceGroups/thes-hsm/providers/Microsoft.KeyVault/vaults/thes-kv-germanywestcentr/keys/thes-key-1"
    "tags" = tomap({
      "kcv:PUB-HASH-SHA-1" = "54319776A79D893C9D15B73EB48A76CEE2DA3E8C"
      "original-label" = "thes-key-1"
    })
    "timeouts" = null /* object */
    "version" = "67a217a40a614b218df2dfd448b66d75"
    "versionless_id" = "https://thes-kv-germanywestcentr.vault.azure.net/keys/thes-key-1"
    "x" = ""
    "y" = ""
  },
  {
    "curve" = ""
    "e" = "AQAB"
    "id" = "https://thes-kv-germanywestcentr.vault.azure.net/keys/thes-key-2/76213aa75b234a4e9ebda0171487d7c2"
    "key_opts" = tolist([
      "encrypt",
      "decrypt",
      "wrapKey",
      "unwrapKey",
      "sign",
      "verify",
    ])
    "key_size" = tonumber(null)
    "key_type" = "RSA-HSM"
    "key_vault_id" = "/subscriptions/ff31b71c-d9b7-4f2e-ae63-fe2e02acdfe1/resourceGroups/thes-hsm/providers/Microsoft.KeyVault/vaults/thes-kv-germanywestcentr"
    "n" = "tXXyK1vSjypb0jOs5d3oqwnzmz3WuVaCordh7zPOaYUW14mhagbultJ2fbKSjn4Q1AZ4BQifPL2-FV0RR8tsr0-zyadpxrByv6APBqvp-1KBb927PNClh_ua-yjoysUlLyFsQpnC_APtNYfkARStgMJdMsy05oj2rLUnzCGzGuWZps_xcpKWI7jY73wbuebrSIrpEdSknNzvikh0sxwToxD5yLYpCmsopbyXhUf5uxGRXDaGemDWH_7DgJQAOvGRDftyCbu9j4aNAXRq7Q1ITW7M2VI_kFSUtg9h6rtpAvw2rZ8pLmZiGSmDPXdG9_qGbReDLMBkYfsBbSUfAWFitw"
    "name" = "thes-key-2"
    "public_key_openssh" = <<-EOT
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1dfIrW9KPKlvSM6zl3eirCfObPda5VoKit2HvM85phRbXiaFqBu6W0nZ9spKOfhDUBngFCJ88vb4VXRFHy2yvT7PJp2nGsHK/oA8Gq+n7UoFv3bs80KWH+5r7KOjKxSUvIWxCmcL8A+01h+QBFK2Awl0yzLTmiPastSfMIbMa5Zmmz/FykpYjuNjvfBu55utIiukR1KSc3O+KSHSzHBOjEPnItikKayilvJeFR/m7EZFcNoZ6YNYf/sOAlAA68ZEN+3IJu72Pho0BdGrtDUhNbszZUj+QVJS2D2Hqu2kC/DatnykuZmIZKYM9d0b3+oZtF4MswGRh+wFtJR8BYWK3

    EOT
    "public_key_pem" = <<-EOT
    -----BEGIN PUBLIC KEY-----
    MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtXXyK1vSjypb0jOs5d3o
    qwnzmz3WuVaCordh7zPOaYUW14mhagbultJ2fbKSjn4Q1AZ4BQifPL2+FV0RR8ts
    r0+zyadpxrByv6APBqvp+1KBb927PNClh/ua+yjoysUlLyFsQpnC/APtNYfkARSt
    gMJdMsy05oj2rLUnzCGzGuWZps/xcpKWI7jY73wbuebrSIrpEdSknNzvikh0sxwT
    oxD5yLYpCmsopbyXhUf5uxGRXDaGemDWH/7DgJQAOvGRDftyCbu9j4aNAXRq7Q1I
    TW7M2VI/kFSUtg9h6rtpAvw2rZ8pLmZiGSmDPXdG9/qGbReDLMBkYfsBbSUfAWFi
    twIDAQAB
    -----END PUBLIC KEY-----

    EOT
    "resource_id" = "/subscriptions/ff31b71c-d9b7-4f2e-ae63-fe2e02acdfe1/resourceGroups/thes-hsm/providers/Microsoft.KeyVault/vaults/thes-kv-germanywestcentr/keys/thes-key-2/versions/76213aa75b234a4e9ebda0171487d7c2"
    "resource_versionless_id" = "/subscriptions/ff31b71c-d9b7-4f2e-ae63-fe2e02acdfe1/resourceGroups/thes-hsm/providers/Microsoft.KeyVault/vaults/thes-kv-germanywestcentr/keys/thes-key-2"
    "tags" = tomap({
      "kcv:PUB-HASH-SHA-1" = "6B6E765660BBEC7F015E76E388088A1871614AE9"
      "original-label" = "thes-key-2"
    })
    "timeouts" = null /* object */
    "version" = "76213aa75b234a4e9ebda0171487d7c2"
    "versionless_id" = "https://thes-kv-germanywestcentr.vault.azure.net/keys/thes-key-2"
    "x" = ""
    "y" = ""
  },
]
azure_keys_westeurope = [
  {
    "curve" = ""
    "e" = "AQAB"
    "id" = "https://thes-kv-westeurope.vault.azure.net/keys/thes-key-1/d92a71dbffd64b82a6735a36805095d7"
    "key_opts" = tolist([
      "encrypt",
      "decrypt",
      "wrapKey",
      "unwrapKey",
      "sign",
      "verify",
    ])
    "key_size" = tonumber(null)
    "key_type" = "RSA-HSM"
    "key_vault_id" = "/subscriptions/ff31b71c-d9b7-4f2e-ae63-fe2e02acdfe1/resourceGroups/thes-hsm/providers/Microsoft.KeyVault/vaults/thes-kv-westeurope"
    "n" = "qeVB_DgC2XKBEgI6IQpUZ_JRbidDzOVbnHL1RFo7EUuFuiS4dsQ_tuz0Dg7KLvabeM1v41DkFHiqh6KKPLQS1n-FA_EIYWGjZtVMAdvjWKQkDy5jIZjxsKra_KtF8yD75qV125dCo7Seeje9pKCjxm3Ut7ZDjPO51PE2ix2wnLh5i7342ugWpvV6pQYha1Q6i_eXDNveaUuG-WsTsb1i5pTxv-oJ-x9LKdUzCe1Nq4GNPIZug4rcxfd70XjZdWAWlWr4FlZ1Z67zpCpSkDbsm6AkNEKgMh9EPJfNqxAD3W9fZC3WeWyczEcBnuVTKg3-c_z4Hihh8rU0dwsr2clA0w"
    "name" = "thes-key-1"
    "public_key_openssh" = <<-EOT
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCp5UH8OALZcoESAjohClRn8lFuJ0PM5VuccvVEWjsRS4W6JLh2xD+27PQODsou9pt4zW/jUOQUeKqHooo8tBLWf4UD8QhhYaNm1UwB2+NYpCQPLmMhmPGwqtr8q0XzIPvmpXXbl0KjtJ56N72koKPGbdS3tkOM87nU8TaLHbCcuHmLvfja6Bam9XqlBiFrVDqL95cM295pS4b5axOxvWLmlPG/6gn7H0sp1TMJ7U2rgY08hm6DitzF93vReNl1YBaVavgWVnVnrvOkKlKQNuyboCQ0QqAyH0Q8l82rEAPdb19kLdZ5bJzMRwGe5VMqDf5z/PgeKGHytTR3CyvZyUDT

    EOT
    "public_key_pem" = <<-EOT
    -----BEGIN PUBLIC KEY-----
    MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqeVB/DgC2XKBEgI6IQpU
    Z/JRbidDzOVbnHL1RFo7EUuFuiS4dsQ/tuz0Dg7KLvabeM1v41DkFHiqh6KKPLQS
    1n+FA/EIYWGjZtVMAdvjWKQkDy5jIZjxsKra/KtF8yD75qV125dCo7Seeje9pKCj
    xm3Ut7ZDjPO51PE2ix2wnLh5i7342ugWpvV6pQYha1Q6i/eXDNveaUuG+WsTsb1i
    5pTxv+oJ+x9LKdUzCe1Nq4GNPIZug4rcxfd70XjZdWAWlWr4FlZ1Z67zpCpSkDbs
    m6AkNEKgMh9EPJfNqxAD3W9fZC3WeWyczEcBnuVTKg3+c/z4Hihh8rU0dwsr2clA
    0wIDAQAB
    -----END PUBLIC KEY-----

    EOT
    "resource_id" = "/subscriptions/ff31b71c-d9b7-4f2e-ae63-fe2e02acdfe1/resourceGroups/thes-hsm/providers/Microsoft.KeyVault/vaults/thes-kv-westeurope/keys/thes-key-1/versions/d92a71dbffd64b82a6735a36805095d7"
    "resource_versionless_id" = "/subscriptions/ff31b71c-d9b7-4f2e-ae63-fe2e02acdfe1/resourceGroups/thes-hsm/providers/Microsoft.KeyVault/vaults/thes-kv-westeurope/keys/thes-key-1"
    "tags" = tomap({
      "kcv:PUB-HASH-SHA-1" = "54319776A79D893C9D15B73EB48A76CEE2DA3E8C"
      "original-label" = "thes-key-1"
    })
    "timeouts" = null /* object */
    "version" = "d92a71dbffd64b82a6735a36805095d7"
    "versionless_id" = "https://thes-kv-westeurope.vault.azure.net/keys/thes-key-1"
    "x" = ""
    "y" = ""
  },
  {
    "curve" = ""
    "e" = "AQAB"
    "id" = "https://thes-kv-westeurope.vault.azure.net/keys/thes-key-2/9ada4b341baf4e61abaaac9228f39c31"
    "key_opts" = tolist([
      "encrypt",
      "decrypt",
      "wrapKey",
      "unwrapKey",
      "sign",
      "verify",
    ])
    "key_size" = tonumber(null)
    "key_type" = "RSA-HSM"
    "key_vault_id" = "/subscriptions/ff31b71c-d9b7-4f2e-ae63-fe2e02acdfe1/resourceGroups/thes-hsm/providers/Microsoft.KeyVault/vaults/thes-kv-westeurope"
    "n" = "tXXyK1vSjypb0jOs5d3oqwnzmz3WuVaCordh7zPOaYUW14mhagbultJ2fbKSjn4Q1AZ4BQifPL2-FV0RR8tsr0-zyadpxrByv6APBqvp-1KBb927PNClh_ua-yjoysUlLyFsQpnC_APtNYfkARStgMJdMsy05oj2rLUnzCGzGuWZps_xcpKWI7jY73wbuebrSIrpEdSknNzvikh0sxwToxD5yLYpCmsopbyXhUf5uxGRXDaGemDWH_7DgJQAOvGRDftyCbu9j4aNAXRq7Q1ITW7M2VI_kFSUtg9h6rtpAvw2rZ8pLmZiGSmDPXdG9_qGbReDLMBkYfsBbSUfAWFitw"
    "name" = "thes-key-2"
    "public_key_openssh" = <<-EOT
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1dfIrW9KPKlvSM6zl3eirCfObPda5VoKit2HvM85phRbXiaFqBu6W0nZ9spKOfhDUBngFCJ88vb4VXRFHy2yvT7PJp2nGsHK/oA8Gq+n7UoFv3bs80KWH+5r7KOjKxSUvIWxCmcL8A+01h+QBFK2Awl0yzLTmiPastSfMIbMa5Zmmz/FykpYjuNjvfBu55utIiukR1KSc3O+KSHSzHBOjEPnItikKayilvJeFR/m7EZFcNoZ6YNYf/sOAlAA68ZEN+3IJu72Pho0BdGrtDUhNbszZUj+QVJS2D2Hqu2kC/DatnykuZmIZKYM9d0b3+oZtF4MswGRh+wFtJR8BYWK3

    EOT
    "public_key_pem" = <<-EOT
    -----BEGIN PUBLIC KEY-----
    MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtXXyK1vSjypb0jOs5d3o
    qwnzmz3WuVaCordh7zPOaYUW14mhagbultJ2fbKSjn4Q1AZ4BQifPL2+FV0RR8ts
    r0+zyadpxrByv6APBqvp+1KBb927PNClh/ua+yjoysUlLyFsQpnC/APtNYfkARSt
    gMJdMsy05oj2rLUnzCGzGuWZps/xcpKWI7jY73wbuebrSIrpEdSknNzvikh0sxwT
    oxD5yLYpCmsopbyXhUf5uxGRXDaGemDWH/7DgJQAOvGRDftyCbu9j4aNAXRq7Q1I
    TW7M2VI/kFSUtg9h6rtpAvw2rZ8pLmZiGSmDPXdG9/qGbReDLMBkYfsBbSUfAWFi
    twIDAQAB
    -----END PUBLIC KEY-----

    EOT
    "resource_id" = "/subscriptions/ff31b71c-d9b7-4f2e-ae63-fe2e02acdfe1/resourceGroups/thes-hsm/providers/Microsoft.KeyVault/vaults/thes-kv-westeurope/keys/thes-key-2/versions/9ada4b341baf4e61abaaac9228f39c31"
    "resource_versionless_id" = "/subscriptions/ff31b71c-d9b7-4f2e-ae63-fe2e02acdfe1/resourceGroups/thes-hsm/providers/Microsoft.KeyVault/vaults/thes-kv-westeurope/keys/thes-key-2"
    "tags" = tomap({
      "kcv:PUB-HASH-SHA-1" = "6B6E765660BBEC7F015E76E388088A1871614AE9"
      "original-label" = "thes-key-2"
    })
    "timeouts" = null /* object */
    "version" = "9ada4b341baf4e61abaaac9228f39c31"
    "versionless_id" = "https://thes-kv-westeurope.vault.azure.net/keys/thes-key-2"
    "x" = ""
    "y" = ""
  },
]
```
