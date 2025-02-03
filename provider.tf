terraform{
    required_providers{
      azurem={
        source="hashicorp/azurerm"
        version= ">=3.70.0"#this version azurem, not terraform version
      }
    }
    required_version=">=1.4.0"#this version is for terraform version, not azurem
}

provider "azurem"{
    features{}
    subscription_id=var.subscription_id
    client_id=var .client_id
    client_secret=var.client_secret
    tenant_id=var.tenant_id
}
