

Vagrantfile deploys a vagrant box based on CentOS and installs terraform. 
Use for Oracle Cloud Infrastructure provisioning purposes. 

Prerequisites:

Install Virtual Box: go with version 6.0.4 - https://www.virtualbox.org/wiki/Downloads

Install Vagrant: https://www.vagrantup.com/downloads.html

Add the Virtual Box guest additions plugin for Vagrant by running this in the command line: 

$ vagrant plugin install vagrant-vbguest

Install Git: https://git-scm.com/downloads

Use a code editor such as Visual Studio Code: https://code.visualstudio.com/download

(optional) Add VS Code plugins for: Github, Terraform, Vagrant

Copy the Vagrantfile file into your work folder, edit it accordingly to the comments and issue a "vagrant up" command to launch the box

Once it's deployed issue the "vagrant ssh" command and start terraforming!
