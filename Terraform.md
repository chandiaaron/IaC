# Terraform 

## What is Terraform 

Terraform is an open-source Infrastructure as Code (IaC) tool by HashiCorp that helps you define, manage, and automate cloud resources using a simple configuration language (HCL). It allows you to provision and manage infrastructure across multiple providers like AWS, Azure, and Google Cloud efficiently.

## How to download Terraform

- Firstly you want to go to the official Terraform downloads page, in this tutorial i will be using windows : [Terraform Downloads](https://developer.hashicorp.com/terraform/install)

- Once you have downloaded the file you can unzip the folder and save the folder with the excutable file to your local disk 

- Next we want to add that folder to the Windows Path environment variable section because it will allows us to run terraform from any command prompt without needing to navigate to its installation folder manually. 

    - on your system if you search **edit system environment variables** 
    - next click **Environment variables**
    - on system variables we want to edit **path**, click **new** add the file path for the folder and click okay 


- if you run powershell and input 

```Powershell
terraform -help
```

you should get the following out put to confirm everything was set up properly :

![terra confirmation download](/Images/terra.JPG)

# Terraform Commands 

1) The terraform init command is used to initialise a terraform working directory. For example it downloads provider plugins like AWS. 

```Terraform
terraform init
```

2) The fmt command will format everything in terms of correcting indentation, spacing and alignment to make your code more consistent and readable 

```Terraform
terraform fmt
```

3) The plan command is used to preview the changes Terraform will make to your infrastructure based on the configuration you have written. 

```Terraform
terraform plan
```

4) The apply command will apply the changes to your infrastructure that were previously planned and confirmed.

```Terraform
terraform apply
```

5) The destroy command will delete all resources that terraform manages in your configuration, for example any launched instances will now be terminated. 
```Terraform
terraform destroy
```

# The importance of the gitignore file

These are the files that should not be tracked because : 

1) terraform.tfstate and terraform.tfstate.backup 

Always ignore because they contain sensitive infrastructure information 

2) variables.tf 

we may want to keep certain information private so we mask values with variables but we dont disclose the value of those variables 

3) terraform.lock.hcl

The main reason you might not want to track terraform.lock.hcl is that it locks your provider versions, which means Terraform will always use the exact versions specified in that lock file.


4) terraform/ 

 The .terraform/ directory can become quite large because it contains provider plugins and downloaded modules. Committing these files to a Git repository adds unnecessary bloat to your repository

 5) gitignore 

 having gitignore listed in the file itself ensures it won't get committed. It effectively tells Git to not track the gitignore file at all.