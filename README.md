# Terraform Modules

Compilation of Terraform modules used for different tasks.

The contents of this repository are for EXAMPLE PURPOSE ONLY and should not be used in an an environment without prior user validation and testing.

- [Terraform Modules](#terraform-modules)
  - [Requirements](#requirements)
  - [Modules Included](#modules-included)
  - [Other Examples](#other-examples)
  - [Usage](#usage)
    - [az_resource_group](#az_resource_group)
    - [az_aks_cluster_linux](#az_aks_cluster_linux)
    - [az_aks_cluster_arc](#az_aks_cluster_arc)
    - [az_vm_linux](#az_vm_linux)

## Requirements

- Terraform 1.2+ [docs](https://www.terraform.io/)
- Azure CLI 2+ [docs](https://docs.microsoft.com/en-us/cli/azure/)

## Modules Included

- [modules/az_resource_group](#az_resource_group) : Used to create an Azure Resource Group along with an associated VNET and NSG.
- [modules/az_aks_cluster_linux](#az_aks_cluster_linux) : Used to create an Azure Managed Kubernetes Service.  Relies upon an existing Resource Group and VNET.
- [modules/az_vm_linux](#az_vm_linux) : Used to create a Linux Azure Virtual Machine (Default Ubuntu 22.04).  Relies upon an existing Resource Group and VNET.

## Other Examples

- [./az_aks_cluster_arc](#az_aks_cluster_arc): Used to create an Azure Managed Kubernetes Service (with [modules/az_aks_cluster_linux](#az_aks_cluster_linux)) and register an Actions Runner Controller deployment.

---

## Usage

### az_resource_group

Resources Created:

- Azure Resource Group
- Azure Virtual Network (VNET) with associated Subnet.
- Azure Network Security Group (NSG) with rules allowing `ssh` (ports `22` and `122`), `winrm` & `rdp`.

  ```mermaid
  graph
  subgraph Azure Resource Group
    subgraph Virtual-Network
      s(Subnet)
    end
    subgraph Network-Security-Group
      r1(rule)
      r2(rule)
    end
  end

  %% apply styling
  classDef blue fill:#096bde
  class Virtual-Network,Network-Security-Group blue
  ```

Usage:

- Perform work from the [az_resource_group](./az_resource_group) top-level directory.
- verify that [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) is installed and you are properly authenticated (`az login`).
- Rename [main.tf.example](./az_resource_group/main.tf.example) to be `main.tf` and update all values.
- run `terraform init`
- Execute `terraform plan` to confirm there are no errors.
- Execute `terraform apply` to build the infrastructure.  This will create with module source of [modules/az_resource_group](./modules/az_resource_group/).
- Execute `terraform destroy` when completed to clean-up any resources created.

---

### az_aks_cluster_linux

The [az_aks_cluster_linux](./az_aks_cluster_linux) module requires that an Azure Resource Group is already created.  Use the [az_resource_group](#az_resource_group) module to create a Resource Group, if needed.

  ```mermaid
  graph
  subgraph Azure Resource Group
    subgraph AKS
      n(NodePool)
    end
  end

  %% apply styling
  classDef blue fill:#096bde
  class Virtual-Network,AKS blue
  ```

Usage:

- Perform work from the [az_aks_cluster_linux](./az_aks_cluster_linux) top-level directory.
- verify that [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) is installed and you are properly authenticated (`az login`).
- Rename [main.tf.example](./az_aks_cluster_linux/main.tf.example) to be `main.tf` and update all values.
- run `terraform init`
- Execute `terraform plan` to confirm there are no errors.
- Execute `terraform apply` to build the infrastructure.  This will create with module source of [modules/az_aks_cluster_linux](./modules/az_aks_cluster_linux/).
- Execute `terraform destroy` when completed to clean-up any resources created.

---

### az_aks_cluster_arc

The [az_aks_cluster_arc](#az_aks_cluster_arc) is used to build an Azure Managed Kubernetes Service cluster and then deploy [Actions Runner Controller](https://github.com/actions-runner-controller/actions-runner-controller)(ARC).  This example will create an ARC deployment and register a Webhook on the target Organization(s).

**Currently only works with GitHub Enterprise Server(GHES)**

  ```mermaid
  graph
  subgraph AKS
    subgraph NodePool
      arc1(Arc Pod org1)
      arc2(Arc Pod org2)
      arcx(Arc Pod orgX)
      wh(Webhook Service)
    end
  end

  subgraph GHES
    org1 & org2 & orgX -. webhook .-> wh
    arc1
    arc2
    arcx
  end
  %% apply styling
  classDef blue fill:#096bde
  class NodePool blue
  ```

Usage:

- Perform work from the [az_aks_cluster_arc](#az_aks_cluster_arc) top-level directory.
- Verify that [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) is installed and you are properly authenticated (`az login`).
- Verify that [kubectl](https://kubernetes.io/docs/tasks/tools/) is installed.
- Have a target Organization (or Organizations) created along with a [Personal Access Token properly scoped for Actions Runner Controller](https://github.com/actions-runner-controller/actions-runner-controller#deploying-using-pat-authentication).
- Rename [main.tf.example](./az_aks_cluster_arc/main.tf.example) to be `main.tf` and update all values.
- run `terraform init`
- Execute `terraform plan` to confirm there are no errors.
- Execute `terraform apply` to build the infrastructure.  This will create with module source of [modules/az_aks_cluster_linux](./modules/az_aks_cluster_linux/) along with resources defined locally within [main.tf](./az_aks_cluster_arc/main.tf)
- Verify that the ARC runners were created and are registered properly to the target Organization(s) and that the webhook(s) status is Active without errors.
- Execute `terraform destroy` when completed to clean-up any resources created.

---

### az_vm_linux

The [az_vm_linux](./az_vm_linux) module requires that an Azure Resource Group is already created.  Use the [az_resource_group](#az_resource_group) module to create a Resource Group, if needed.

Usage:

- Perform work from the [az_vm_linux](./az_vm_linux) top-level directory.
- verify that [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) is installed and you are properly authenticated (`az login`).
- Rename [main.tf.example](./az_vm_linux/main.tf.example) to be `main.tf` and update all values.
- run `terraform init`
- Execute `terraform plan` to confirm there are no errors.
- Execute `terraform apply` to build the infrastructure.  This will create with module source of [modules/az_vm_linux](./modules/az_vm_linux/).
- Execute `terraform destroy` when completed to clean-up any resources created.
