## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![RedTeam Network] (https://github.com/AsfandiyarQ1/UMN-BootCamp-ElkStack/blob/main/Diagrams/Week%2012%20Homework%20-%20Cloud%20Security.JPG?raw=true)
![ElkStack Network] (https://github.com/AsfandiyarQ1/UMN-BootCamp-ElkStack/blob/main/Diagrams/ELkStackProject.JPG?raw=true)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the .yml file may be used to install only certain pieces of it, such as Filebeat.

![pentest.yml] (https://github.com/AsfandiyarQ1/UMN-BootCamp-ElkStack/blob/main/Ansible/Pentest.yml)

![install-elk.yml] (https://github.com/AsfandiyarQ1/UMN-BootCamp-ElkStack/blob/main/Ansible/Install-Elk.yml)

![filebeat-playbook.yml] (https://github.com/AsfandiyarQ1/UMN-BootCamp-ElkStack/blob/main/Ansible/filebeat-playbook.yml)

![metricbeat-playbook.yml] (https://github.com/AsfandiyarQ1/UMN-BootCamp-ElkStack/blob/main/Ansible/metricbeat-playbook.yml)

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
Load balancers provide availablity, authentication and protect against DDoS attacks. 
The jumpbox provides the ability to controll and monitor, while it is isolated from the local network. It is used to perform all admin duties on the network infrastructure, and also provides integrity of the system and confidentiality.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the VM's logs and system traffic.
- Filebeat logs and monitors log files for changes based on parameters specified by the system administrator 
- Metricbeat collects metrics on the operating systems and services running on the network for analysis

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name                | Function                                           | Local IP  | Public IP      | Operating System        |
|---------------------|----------------------------------------------------|-----------|----------------|-------------------------|
| Jumbox Provisioner  | Remote Access Point  & Ansible configuration point | 10.0.0.4  | 20.106.138.207 | Linux Ubuntu 18.04-LTS  |
| web-1               | Docker-dvwa                                        | 10.0.0.5  | 23.96.54.66    | Linux Ubuntu 18.04-LTS  |
| web-2               | Docker-dvwa                                        | 10.0.0.8  | 23.96.54.66    | Linux Ubuntu 18.04-LTS  |
| web-3               | Docker-dvwa                                        | 10.0.0.9  | 23.96.54.66    | Linux Ubuntu 18.04-LTS  |
| Elk                 | Elk Stack- Elasticsearch, Kibana                   | 10.1.0.4  | 20.62.66.148   | Linux Ubuntu 18.04-LTS  |
| Load Balancer       | Load balances web-1,2, and 3                       |           | 23.96.54.66    |                         |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jumpbox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
71.193.70.49 SSH via port 22
ELK server through 5601

Machines within the network can only be accessed by the Jumpbox using SSH through port 22.
The Jumpbox provisioner can acccess the ELK VM using the internal private ip 10.1.0.4

A summary of the access policies in place can be found in the table below.

| Name                | Publicly Accessible | Allowed IP Addresses      |
|---------------------|---------------------|---------------------------|
| Jumbox Provisioner  | Yes                 | SSH from 71.193.70.49     |
| web-1               | No                  | 10.1.0.4                  |
| web-2               | No                  | 10.1.0.4                  |
| web-3               | No                  | 10.1.0.4                  |
| Elk                 | No                  | 71.193.70.49 through 5601 |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
Ansible allows a user to quickly deploy and easily deploy multiple applications through a playbook.

The playbook implements the following tasks:
- _TODO: In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._
Specifies what to install
- name: Config elk VM with Docker
    hosts: elk
    become: true
    tasks:

Install Docker 
- name: Install docker.io
    apt:
      update_cache: yes
      force_apt_get: yes
      name: docker.io
      state: present

Install Python-pip
- name: Install python3-pip
    apt:
      force_apt_get: yes
      name: python3-pip
      state: present

    # Use pip module (It will default to pip3)
  - name: Install Docker module
    pip:
      name: docker
      state: present
      `docker`, which is the Docker Python pip module
   
 Increase virtual memory
 - name: Use more memory
   sysctl:
     name: vm.max_map_count
     value: '262144'
     state: present
     reload: yes
 
 Download and launch Elk docker container 
 
- name: Download and launch a docker elk container
   docker_container:
     name: elk
     image: sebp/elk:761
     state: started
     restart_policy: always
     
 Available ports
 published_ports:
       -  5601:5601
       -  9200:9200
       -  5044:5044   
    
The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![Docker ps screenshot] (https://github.com/AsfandiyarQ1/UMN-BootCamp-ElkStack/blob/main/Ansible/docker_ps_output.JPG)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
web-1 10.0.0.5
web-2 10.0.0.8
web-3 10.0.0.9

We have installed the following Beats on these machines:
Filebeat and metricbeat 

These Beats allow us to collect the following information from each machine:
Filebeat will be used to collect log files from very specific files such as Apache, Microsft Azure tools and web servers, MySQL databases. Metericbeat will be used to monitor VMs, specifically CPU,filesystem, memory, and network stats.



### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the yml file to ansible folder.
- Update the config file to include remote users and ports
- Run the playbook, and navigate to Kibana to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- Playbook can be downloaded using the curl -L -O https://gist.githubusercontent.com/slape/5cc350109583af6cbe577bbcc0710c93/raw/eca603b72586fbe148c11f9c87bf96a63cb25760/Filebeat > /etc/ansible/filebeat-config.yml
- update hosts file within /etc/ansible and include the IPs of the Webservers
- http://20.62.66.148.IP]:5601/app/kibana

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
