# Deamon with bash

Reference: 
    
 * [Create Deamon Simple](https://www.nimblersoft.com/blog-post/27/how-setup-daemonservice-debian)
 * [Create Deamon in Debian](https://linuxhint.com/systemd_unit_file_service/)

**TASK:** This Deamon: check if our network has internet   
And if dont have update a link: `bit.ly/2PdcQyi` When the internet come back.


**PROBLEM:** My current public ip change all time  
**SOLUTION:** Ceate script for update the URL bitly themelse i will always have access to my House Server  

## Wrong (i need access by auth 2 for to do this)

With bitly api rest  WE CAN'T update the field `long_url`  
I realized than when i started to write ( bad practice :( )  

## Solution to no update the field: long_url

For moment only update the Title from ITEM LINK BITLY  
Solution1: Udating the title I kwnon for for anyway that happend when Im away from home.  
Solution2: To send me one mail  with this change  

## Config and Install

### Step 1:

Set your seft token (create it on your Bitly settings)  

    BITLY_TOKEN=""

### Step 2:

Create Deamon on `DEBIAN` with *systemd*
Copy the file `updateip.service` to `/etc/systemd/system/`
Change the next variables:

    User=YourUser
    ExecStart=locationFromYourScript
    WorkingDirectory=PathlocationFromYourScript

Execute next sentence:

    cp updateip.service /etc/systemd/system/updateip.service

Now start the service: (its fail check the status service)

    sudo systemctl start updateip.service
    sudo systemctl status updateip.service

And automatically get it to start on boot, this is useful for when the main server restarts:
    sudo systemctl enable updateip.service 

### IMG 

![Ref Image BITLY URL UPDATE](README/README.png)

![status updateip service](README/updateip-service.png)