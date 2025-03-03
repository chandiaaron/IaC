# Infrastructure as Code (IaC)

## What is IaC? 

Infrastructure as Code (IaC) is a method of managing and provisioning IT infrastructure (like servers, networks, databases, and storage) using code instead of manual processes.


## Why implement/learn IaC?

Implementing Infrastructure as Code (IaC) brings automation, consistency, and efficiency to managing IT infrastructure. Instead of manually configuring servers and cloud resources, IaC allows you to define everything in code—leading to faster, more reliable deployments.

### Benefits of Infrastructure as Code (IaC)

- **Automation & Speed**   
  - Eliminates manual provisioning—deploy infrastructure in minutes.  
  - Automates cloud resource creation, reducing human errors.  

- **Consistency & Standardisation**   
  - Prevents configuration drift across environments.  
  - Ensures identical setups for dev, staging, and production.  

- **Version Control & Rollbacks**   
  - Infrastructure is stored in Git for easy tracking.  
  - Roll back to previous configurations if an issue arises.  

# What is Orchestration in IaC 

Orchestration refers to the automated coordination and management of multiple infrastructure components to ensure they work together efficiently. 

- provisioning servers and databases together
- Deploying and managing containers in Kubernetes 
- Automating infrastructure scaling and rollback 

For example ensuring a web apllication home page and database servers are provisioned, deployed, and working together properly. 

# What is Configuration Management in IaC 

Configuration Management ensures that the infrastructure and software on provisioned resources are set up correctly and maintained in a desired state. It focuses on managing software versions, configurations, and system settings.

- installing and configuring software on servers 
- Managing OS settings and security policies 
- Applying patches and updates to maintain compliance 

For example making sure you have the right version of MongoDB 

# What is Declarative IaC 

Declarative IaC (Infrastructure as Code) is an approach where you define what you want your infrastructure to look like (the desired end state), but you don’t specify the exact steps to achieve it.

| **Aspect**           | **Declarative IaC**                         | **Imperative IaC**                             |
|----------------------|---------------------------------------------|------------------------------------------------|
| **Focus**            | What the desired state should be.            | How to achieve the desired state (step-by-step). |
| **Level of Control** | More abstract; less control over the steps.  | More detailed control over every action.       |
| **Idempotency**      | Automatically ensures the system matches the desired state. | No inherent idempotency; you must manage the sequence of commands. |
| **Example Tools**    | Terraform, Kubernetes, AWS CloudFormation   | Ansible, Chef, Puppet, shell scripts           |

### what is Idempotency 

Idempotency is a concept where you can perform an operation multiple times, but the result will always be the same, no matter how many times you repeat it. 

If you have a version already up to date and installed, because its already in its desired state this version wont be over ruled by trying to redownload the same version. 

# What is Imperative IaC 

Imperative IaC (Infrastructure as Code) is an approach where you explicitly define the exact steps that need to be taken to achieve the desired infrastructure state. In other words, you tell the system how to achieve the final infrastructure setup, instead of just describing what the final state should look like.


Declarative = "I want this. You figure out how to do it."

Imperative = "Here’s exactly how to do it, step by step."

# Mutable Infrastructure 

In mutable infrastructure, the components of your infrastructure (like servers, virtual machines, or containers) are modified or updated directly over time. You can make changes to the infrastructure while it’s running.

# Immutable Infrastructure 

In immutable infrastructure, the approach is to never modify the existing infrastructure components. Instead of updating or patching running servers or containers, you replace them with new instances or containers that are already configured with the desired state.

