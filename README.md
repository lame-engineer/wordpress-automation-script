# wordpress-automation-script
## Intro to the script 
This script has 4 main functions -
- Check weather docker and docker-compose are installed, if not then install
- **Start**, **Stop** and **Delete** the containers 
- Get url for the application
- Customise the site-name

## Installation or running the script
- The script needs to be run as root (use sudo)
- To run the script first give it appropriate permissions.
    - `chmod +x script_name`
- Run the script by the following command `sudo ./script_name example.com`. This will spin up the containers.
  
  Where the exampl.com would be your very own site name
  
- To stop the containers use `sudo ./script_name stop`
- To delete the containers use `sudo ./script_name destroy`



### The script needs to be run as root because of the following reasons -
- Installing packages
- Making changes in /etc/hosts file


#### This script may not run properly on diffrent OS
- I have tested this script in Arch and Debian based distro.
- You need to change line 70 to suit your OS
- for Debian and its family `sudo apt-get install docker.io docker-compose -y`
- for Redhat family you may use YUM or DNF so it will change like `sudo yum install docker docker-compose -y` or `sudo dnf install docker docker-compose`

In distros other than arch you may not find a latest docker install. therefore use this documentation to do so - [docker docs](https://docs.docker.com/engine/install/)
