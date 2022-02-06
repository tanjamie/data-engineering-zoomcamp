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
### Google Cloud, Anaconda & SSH
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
### Docker & Docker-compose
1. Download and Configure Docker in VM
    - Run `sudo apt-get update`, then `sudo apt-get install docker.io` to install docker
    - Run `docker --version` to check that docker is installed successfully
    - Run `docker run hello-world`, and you should get a permission denied error. To add permissions, do the steps illustrated [here](https://github.com/sindresorhus/guides/blob/main/docker-without-sudo.md). This will allow us to run our code without `sudo`
2. Install docker-compose
    - [Here](https://github.com/docker/compose) is the link to docker-compose's github, go to "Releases" and choose the latest one
    - On the new page, scroll down and copy link for docker-compose-linux-x86_64
    - `ls`, `mkdir bin` to create bin folder where we will store all the executable files
    - Enter the bin directory then run `wget https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -O docker-compose` which downloads docker-compose from the link given and output the file called docker-compose
    - `ls` to see docker-compose downloaded
    - Right now system doesn't know yet that docker-compose file is executable, so do `chmod +x docker-compose`, `ls` again to see the changes
    - `./docker-compose version` to see version of docker-compose downloaded
3. Configure docker-compose 
    - Right now, docker-compose is only visible from the bin directory, but we want it to be visible from any directory
    - So, we need to add /bin directory to the list of environmental path variable in the vm
        - `nano .bashrc`, go to the end of the file
        - Add `export PATH="${HOME}/bin:${PATH}" at the end of the file
        - ctrl + o to save, and ctrl + x to exit
        - Run `source .bashrc` 
        - Use `which docker-compose` and `docker-compose version` to check that the path has been added successfully
### VSCode, PGCLI & Terraform
1. Use code on original repository
    - Clone the original repository into the vm with `git clone https://github.com/DataTalksClub/data-engineering-zoomcamp.git`
    - `cd data-engineering-zoomcamp/week_1_basics_n_setup/2_docker_sql` to enter directory
    - Optional: If port 5432 failed to connect when tested locally because it has been occupied, change the port here too (it will save you trouble later when forwarding port in vm onto local machine) 
    - Run docker-compose with `docker-compose up -d` and use `docker ps` to check that it has run successfully
2. Configure VSCode to access vm locally
    - Go into VScode, install Remote - SSH extension
    - Ctrl + Shift + p and choose "Remote SSH - Connect to host..." and choose "de-zoomcamp" which is the alias for our ssh
    - Open a new terminal, run `ls` to check that connection is successful
    - Enter the data-engineering-zoomcamp directory using "Open Folder" button on the left menu, and we will be able to work with our files on vm as if its our local environment
3. Install PGCLI in vm 
    - Option 1 (Don't run this): Run `pip install pgcli` while in the vm 
        - You will face problems doing this, but this is here for illustration and learning/documentation purpose
        - During installation, you will see errors, this is because system is trying different and earlier versions of pgcli to install, until it finds a compatible version
        - Do `pgcli -h localhost -U root -d ny_taxi` and enter password. This will throw some exceptions, but it is actually working - try `dt` to see schema
    - Option 2 (Better method): 
        - `pip uninstall pgcli` to get rid of the pgcli installed in option 1
        - Do `conda install -c conda-forge pgcli` which downloads the compiled version needed
        - Then run `pip install -U mycli`
        - Now, `pgcli -h localhost -U root -d ny_taxi` should work. You may receive a warning about storing passwords, that's okay
4. Download Terraform
    - From the Terraform [website](https://www.terraform.io/downloads), scroll down and copy the link to download Linux Binary which is compatible with your device e.g. [Amd64](https://releases.hashicorp.com/terraform/1.1.5/terraform_1.1.5_linux_amd64.zip)
    - Go to the bin directory and run `wget https://releases.hashicorp.com/terraform/1.1.5/terraform_1.1.5_linux_amd64.zip`
    - Check that download was successful with `ls`
    - Do `sudo apt-get install unzip` then `unzip terraform_1.1.5_linux_amd64.zip` to unzip file
    - Check unzipping is successful using `terraform -version`
    - Remove zip using `rm terraform_1.1.5_linux_amd64.zip`
5. Configure Terraform
    - Put Credentials into VM
        - `cd data-engineering-zoomcamp/week_1_basics_n_setup/1_terraform_gcp/terraform` to enter directory
        - With this, we will need our service account json credentials from GCP ie.e we need to put the json file into this server, and this can be done using sftp. But first, find the location of your json file and `cd` into the directory
        - `sftp de-zoomcamp` adn `ls` to see files in vm
        - Do `mkdir .gc` and `cd` into it
        - `put ny-rides.json` to put the file into the vm current directory
    - Configure Google CLI
        - Enter terraform directory with `cd data-engineering-zoomcamp/week_1_basics_n_setup/1_terraform_gcp/terraform`
        - Set up Google application credentials environmental variables with `export GOOGLE_APPLICATION_CREDENTIALS=~/.gc/ny-rides.json`
        - `gcloud auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS` to authenticate
    - Set up Terraform
        - `terraform init`
        - `terraform plan`
        - `terraform apply`, this will complain because if you've followed the tutorials so far, you would have had the bucket already on GCP but the state file is on this server
## Working with VM on Local Machine
1. Forward Ports on VM onto our Local Machine
    - Enter VScode, ctrl + tilda to get terminal, and go to PORTS tab
    - Enter Git Bash terminal, do `docker ps` to check the port at which Postgres is running on
    - Enter the Port number into VScode
    - Here on, you can access Postgresql without SSH. Just run `pgcli -h localhost -U root -d ny_taxi` on a new Git Bash terminal and you should be able to `/dt` successfully in the Postgresql
        > **ERROR SOLVER** >> If pgcli hangs indefinately on Git Bash, check that you have used the correct ports. Note if you are using 5431, you will need add `-p 5431` into the command because it takes port 5432 by default i.e. `pgcli -h localhost -p 5431 -U root -d ny_taxi`. If this doesn't work, consider running this on Anaconda Prompt
    - The same thing can be done for port 8080 in VScode, and access them from browser on our local machine
2. Download data on vm using `wget https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2021-01.csv` at the appropriate directory
3. Start a Jupyter notebook in VM
    - `cd data-engineering-zoomcamp/week_1_basics_n_setup/2_docker_sql` into the appropriate directory where jupyter file upload-data.ipynb is located
    - Run `jupyter notebook`
    - Forward the port used using VScode
    - Copy the link provided and search it on your browser to access the jupyter notebook
    - Run cells in Jupyter notebook to insert data into Postgres on vm, in chunks
        - Update port when creating machine if you are using a different one
        - Enter Postgresql using pgcli to check
## Shut Down & Resume VM
1. Shut down
    - Option 1: Go into GCP Console where the VM instances are at, under action, select "Stop". This freezes the machine and should not incur extra cost, outside of the storage space used 
    - Option 2: From the terminal, do `sudo shutdown now`
2. Resume or Restart
    - On GCP where the vm instances are at, under action, select "Start"
    - Copy the new external ip address provided
    - Edit ssh config file with `nano .ssh/config` then replace the HostName with the new external ip
    - Do `ssh de-zoomcamp` to enter vm

*fin*
