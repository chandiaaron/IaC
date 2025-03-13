# Ansible 

## what is Ansible 

Ansible is an open source IT automation tool that can configure systems, deploy software, and more. It's written in python and is designed to be easy to use. 

# Why is Ansible a Configuration Management Tool?

Ansible is a powerful configuration management tool because it automates the deployment and management of systems efficiently. Here are the three key reasons why:

## 1. Idempotency
- Ansible ensures that applying a configuration multiple times results in the same system state, avoiding unintended changes.

## 2. Agentless Architecture
- Unlike other tools, Ansible does not require an agent on managed nodes, using SSH or WinRM for execution, making it simpler to set up and manage.

## 3. Infrastructure as Code (IaC)
- Configurations are defined in YAML-based playbooks, allowing for repeatable, version-controlled infrastructure setups.

# What Problem Does Ansible Solve in DevOps?

Ansible addresses several challenges in DevOps, making automation and configuration management more efficient. Here are the three most important problems it solves:

## 1. Manual Configuration & Inconsistency
- Configuring multiple servers manually is time-consuming and error-prone.
- Ansible automates configuration management, ensuring consistency across all environments.

## 2. Complex Deployment Processes
- Traditional deployment processes involve multiple steps that can break due to human errors.
- Ansible automates application deployment, reducing downtime and making rollbacks easier.

## 3. Infrastructure as Code (IaC) Implementation
- Managing infrastructure manually leads to drift and difficulty in version control.
- Ansible enables Infrastructure as Code (IaC) using YAML-based playbooks for better control and repeatability.


# Key differences between Ansible and traditional shell scripting

| **Aspect**          | **Ansible**                                           | **Traditional Shell Scripting**                          |
|---------------------|-------------------------------------------------------|----------------------------------------------------------|
| **Idempotency**      | Ensures idempotency, meaning repeated runs result in the same system state. | Shell scripts can make unintended changes if run multiple times. |
| **Abstraction & Readability** | Uses YAML-based playbooks, providing a declarative approach that focuses on the system's desired state. | Requires detailed, step-by-step procedural instructions. |
| **Scalability & Management** | Supports managing multiple servers through an inventory and executing tasks in parallel over SSH/WinRM. | Requires manual copying and execution on each server, often with additional logic for multiple systems. |


# Why use Ansible?

Ansible simplifies automation by allowing users to define system configurations and tasks in a human-readable YAML format. It ensures idempotency, meaning that tasks can be safely run multiple times without causing unwanted changes. With its ability to manage multiple systems simultaneously, Ansible streamlines large-scale deployments and maintenance, saving time and reducing the risk of errors.

# How does Ansible work 




# How to launch Ansible 

- First we are going to make our controller instance on AWS 

![controller instance ](/Images/ansi.JPG)

- Next SSH into our controller instance using GitBash 

![ssh into instance ](/Images/ansi2.JPG)

- We are going to run some commands : 

```GitBash

sudo DEBIAN_FRONTEND=noninteractive apt update -y
```

```GitBash

sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
```

```GitBash
sudo DEBIAN=FRONTEND_noninteractive apt-add-repository ppa:ansible/ansible
```

```GitBash
sudo DEBIAN_FRONTEND=noninteractive apt install ansible -y
```

- we can check if we isntalled everything properly by using : 

```GitBash
ansible --version
```
![ssh into instance ](/Images/ansi3.JPG)


- we should now have access to the ansible dir : 

```GitBash
 cd /etc/ansible 
```

- next we are going to change into the ssh dir on our controller instance 
- we are going to make a file which contains our aws.pem key 

- once we have copied our key over we want to add some security by making it read only 

```GitBash
 sudo chmod 400 <.pem>
```

- We want to run the ping command but there is no target instance, so lets make one first 
- make another instance with the same settings but name it the target node 



- when the instance is up we want to copy over the public IP 

- Next we want to add an edit within the hosts file using nano 

```GitBash

[web]
ec2-instance ansible_host=<node target public IP> ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/<.pem key file>

```

we can save that file 

- Now we can run our ping command : 

```GitBash
 sudo ansible all -m ping
```
- you should get the following output

![ssh into instance ](/Images/ansi5.JPG)


# How to interact with two target nodes 

- just like before we are going to set up our target nodes 1 and 2 the same way and set up our controller instance 

- on AWS we are using the same configurations, just name them target-node-1 and target-node-2 

- In the hosts file we are going to follow the same layout :

```GitBash
[web]
ec2-instance1 ansible_host=<node target public IP> ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/<.pem key file>
ec2-instance2 ansible_host=<node target public IP> ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/<.pem key file>
```

- To ensure we can interact with multiple instances we have to edit the **.cfg** file :

```GitBash
[defaults]
host_key_checking = False
interpreter_python = auto_silent
```


- we can the ping command to check if everything is working : 

```GitBash
 sudo ansible all -m ping
```

## Best practice commands for Ansible 

```GitBash
 sudo ansible web -m ansible.builtin.apt -a "update_cache=yes" --become
 
sudo ansible web -m ansible.builtin.apt -a "upgrade=dist" --become
```

- The first command ensures up to date package lists, preventing errors and consistent results 
- The second command is used to upgrade all installed packages on the target hosts 


# Making our first Playbook - installing nginx 

we want to create a file called install_nginx_playbook.yml : 

```GitBash
sudo nano install_nginx_playbook.yml
```

Next we want to copy our code into that file : 

```GitBash
# starts with --- (three dashes)
---

# Name of the play
- name: install nginx play 
  # where do you want to install or run this playbook
  hosts: web

  # gather facts?
  gather_facts: yes

  # provide admin(sudo) access to this playbook?
  become: true 

  # instructions - known as "tasks"
  # task = install nginx web server in target node 
  tasks:

  # apt update
  - name: Update all packages
    ansible.builtin.apt:
      update_cache: yes
  
  # apt upgrade
  - name: Upgrade all packages
    ansible.builtin.apt:
      upgrade: dist

  # install nginx
  - name: install and configure nginx on target node
    # use package "nginx", "state=present" means package must be present and installed
    apt: pkg=nginx state=present
```

- Once we are happy save the file and now we can check syntax : 

```GitBash 
sudo ansible-playbook --syntax-check install_nginx_playbook.yml
```
![playbook syntax check ](/Images/ansi6.JPG)

- Next we check the results of the playbook before running it : 

```GitBash 
sudo ansible-playbook --check install_nginx_playbook.yml
```
![playbook check](/Images/ansi7.JPG)

- Finally we can run it : 
```GitBash
 sudo ansible-playbook install_nginx_playbook.yml
```

If we take the public IP of our target node nginx should be running 

![playbook install](/Images/ansi8.JPG)

