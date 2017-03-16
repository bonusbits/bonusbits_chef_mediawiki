# Bonusbits Mediawiki on Nginx in AWS Chef Cookbook and CloudFormation Template
[![CircleCI](https://circleci.com/gh/bonusbits/bonusbits_mediawiki_nginx.svg?style=shield)](https://circleci.com/gh/bonusbits/bonusbits_mediawiki_nginx)
[![Code Climate](https://codeclimate.com/github/bonusbits/bonusbits_mediawiki_nginx/badges/gpa.svg)](https://codeclimate.com/github/bonusbits/bonusbits_mediawiki_nginx)
[![Join the chat at https://gitter.im/bonusbits/bonusbits_mediawiki_nginx](https://badges.gitter.im/bonusbits/bonusbits_mediawiki_nginx.svg)](https://gitter.im/bonusbits/bonusbits_mediawiki_nginx?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

# Purpose
Deploy an autoscaling group with EC2 Instances on Amazon Linux Running Mediawiki on Nginx. Using RDS backend and EFS for content sharing (uploads). 

No ELB/ALB configured, because we deploy behind an existing Sophos load balancer.

# Prerequisites
* VPC with Public (If Using ALB) and Private subnets
    * [Example Template](https://github.com/bonusbits/cloudformation_templates/blob/master/infrastructure/vpc.yml)
* Create RDS Instance 
    * [Example Template](https://github.com/bonusbits/cloudformation_templates/tree/master/database)
* Create Empty Mediawiki Database and User
    * [Wiki Article](https://www.bonusbits.com/wiki/Reference:Secure_Mediawiki_Nginx_Configuration)
* EFS Mount Storage Created
    * [Example Template](https://github.com/bonusbits/cloudformation_templates/blob/master/storage/efs.yml)
* Internet Access from EC2 Instance
    * [Example NAT Gateway Template](https://github.com/bonusbits/cloudformation_templates/blob/master/infrastructure/nat-gateway.yml)
    * [Example VPN BGP Template](https://github.com/bonusbits/cloudformation_templates/blob/master/infrastructure/vpn-bgp.yml)
    * [Example Sophos UTM 9 Template](https://github.com/bonusbits/cloudformation_templates/blob/master/infrastructure/utm9.yml)


# Launcher
Click this button to open AWS CloudFormation web console with the Template URL automatically entered.<br>
[![](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?#/stacks/new?&templateURL=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/cookbooks/bonusbits-mediawiki-nginx.yml)


# CloudFormation Template Details
Public S3 Link:<br> 
[https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/cookbooks/bonusbits-mediawiki-nginx.yml](https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/cookbooks/bonusbits-mediawiki-nginx.yml)

The [CloudFormation Template](https://github.com/bonusbits/bonusbits_mediawiki_nginx/blob/master/cloudformation/bonusbits-mediawiki-nginx.yml)  the following:

1. Create Autoscale Group for Frontend Web Server in private network for HA not Scaling (Currently)
2. Adds the EC2 Instance to the appropriate security groups
3. Create own Security Group
4. Create IAM Instance Profile Role
5. Create Cloudwatch CPU Alarm for Autoscale Group
6. UserData
    Installs some basic packages needed for bootstrapping
    1. cfn-init
    2. aws-cfn-bootstrap
    3. cloud-init
    4. git
7. Cloud Init (cfn-init)
    1. Configure CFN Hup and Auto Reloader Hook Conf
    2. Setup and Execute Chef Zero
        1. Install Chef Client from internet
        2. Create Chef Configuration Files
        3. Download bonusbits_mediawiki_nginx cookbook from Github
        4. Triggers Chef Zero run
    3. Run DNS Update Script (Optional)
    4. Warm EBS Volume  

# Cookbook
1. Adjust Sudoers secure path to include */usr/local/bin*
2. Install Linux packages for Mediawiki, Nginx and PHP FPM
1. Configure Nginx
4. Configure PHP FPM
5. Install specific version of Mediawiki and list of extensions
6. Create LocalSettings.php
7. Configure Extensions
8. Mount and Configure fstab for EFS share
9. Install and configure CloudWatch Logs Agent
10. Setup EFS share backup to encrypted/versioned S3 bucket
11. Create node info script
12. Create Route53 DNS Upset script

# Tips
1. If needed the instance size can be increased.
2. Optionally you could add an ELB and scale past one, but I designed it to be an affordable easy solution. 

# Disclaimer
All of the example values are randomly generated and not real or used by Bonus Bits. 
Such as, data bag secret, HostedZoneId, etc. 
Other times it's more obvious that example values are fake such as vpc-0000000. 
We just added random values to a few specific parameters and attributes to give a better idea of what should be entered.

The point is, don't think we put any real secrets in the repo.

Also, this is a highly customized Mediawiki implementation for our needs and may be outside the scope of what you would like to implement. 
The main purpose is to share code ideas that you can use for your own project. Use are your own cost and risk. 
Don't rely on us to maintain the projects for your needs. Fork away and enjoy the help to success! 

We'll maintain this project for our needs and we hope it helps others on similar implementations!