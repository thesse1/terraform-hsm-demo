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
