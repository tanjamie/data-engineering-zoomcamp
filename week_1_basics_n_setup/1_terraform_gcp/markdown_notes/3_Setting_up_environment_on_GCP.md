# Set up Environment on GCP

## Virtual Machine Instance
1. Enter tribar >> compute engine >> virtual machine (VM) instance
2. Enable Compute Engine API if it is not yet done
3. Generate SSH key to look into a vm instance
    - Git Bash has a SSH client by default, so it is more convinient to work with it
    - Enter .ssh/ directory i.e. `cd .ssh/`. Create the directory if you don't have it with `mkdir .ssh`
    - Create ssh key using command illustrated [here](https://cloud.google.com/compute/docs/connect/create-ssh-keys#linux-and-macos)
        - `ssh-keygen -t rsa -f gcp -C 20jam -b 2048` creates a file named gcp with 20jam as the user attached
            - Note, the user here is the user we will use in the vm itself
        - You will be prompted to give a passphrase, but you can leave it empty
        - `ls` at the .ssh folder to see your public and private key
    - Put public key onto GCP
        - Go to Metadata and into the ssh keys tab on GCP, click "Add SSH Key"
        - Access your public key with `cat gcp.pub` iin your terminal and insert your public key onto GCP then save
        - All the vm instances we create in this project will inherit this SSH key
    - Create vm instance
        - On the "VM instance" page, click "CREATE INSTANCE"
        - Enter "Name", choose "Region" close to you and "Machine Type" e2-standard-4, you will see estimate of cost by the side. To ensure we do not run out of credit, we will need to shut down the instance when we are not working on the machine and turn it on again when needed
        - Change "Boot disk" operating system to "Ubuntu", version to "20.04 LTS" and size to 30
        - Click "Create", copy "External IP" and run the command `ssh -i ~/.ssh/gcp 20jam@34.87.33.50`, substitue your filename, user and external ip respectively
        - Do `htop` to learn what type of machine we have been allocated e.g. number of cores, gbs given etc

## Download and Configure packages required on VM
1. The vm should have Google Cloud SDK by default, `gcloud --version` to check that
2. Download and Configure Anaconda in VM
    - Download anaconda from [here](https://www.anaconda.com/products/individual), scroll to the bottom and copy the link of the Linux 64-Bit (x86) Installer (581 MB). Run `wget <copied link>` to download anaconda in vm
    - Do `bash Anaconda3-2021.11-Linux-x86_64.sh`, enter, read terms and service, accept license and confirm path to unpack payload within the vm
    - Initialize anaconda
    - Do `ls` to see folders in the vm and `less .bashrc` to see its contents. Note that .bashrc is the folder that runs everytimes we look into the vm
        > **ERROR SOLVER** >> If ctrl + c and ctrl + d doesn't work for you when trying to exit `less .bashrc`, do ctrl + z 
3. Configure ssh access to the vm server
    - `touch config` to create a file to called config, where we will configure ssh
    - `code config` to open the config file in our default editor
        - `Host` to give an alias
        - `HostName` to specify the external ip
        - `User` is the user in vm
        - `Identityfile` to enter the path on local machine to our private ssh key
    - Do `ssh de-zoomcamp`, where de-zoomcamp is my alias set in the config file, to enter vm directly     
        > **ERROR SOLVER** >> If you get `Bad configuration option` error, check for typo in your config file. Otherwise, it could be because your filepath contains cyrillic characters. Consider repeating the steps but in a different folder.
    - Loging in and out of vm
        - Logout using ctrl + d, then to login again, execute `ssh de-zoomcamp` again
        - `source .bashrc` to enter vm from Anaconda
    - Optional: Run python in vm
        - `which python` in (base)
        - `python` to signal the use of python script
        - `import pandas as pd` and `pd.__version__` python commands
4. Download and Configure Docker in VM
