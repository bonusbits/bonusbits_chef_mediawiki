# Bonusbits Mediawiki on Nginx in AWS Chef Cookbook and CloudFormation Template
[![CircleCI](https://circleci.com/gh/bonusbits/bonusbits_mediawiki_nginx.svg?style=shield)](https://circleci.com/gh/bonusbits/bonusbits_mediawiki_nginx)
[![Code Climate](https://codeclimate.com/github/bonusbits/bonusbits_mediawiki_nginx/badges/gpa.svg)](https://codeclimate.com/github/bonusbits/bonusbits_mediawiki_nginx)
[![Join the chat at https://gitter.im/stelligent/mu](https://badges.gitter.im/bonusbits/bonusbits_mediawiki_nginx.svg)](https://gitter.im/bonusbits/bonusbits_mediawiki_nginx?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

# Purpose
Deploy an autoscaling group with EC2 Instances on Amazon Linux Running Mediawiki on Nginx. Using RDS backend and EFS for content sharing (uploads). 
Optional an ALB can be applied. It's option because we may want to deploy behind an existing 3rd party cloud load balancer such as Sophos United Threat Management Instance/s.

# Prerequisites
* VPC with Public (If Using ALB) and Private subnets
    * [Example Template](https://github.com/bonusbits/cloudformation_templates/blob/master/infrastructure/vpc.yml)
* Create RDS Instance 
    * [Example Template](https://github.com/bonusbits/cloudformation_templates/tree/master/database)
* Create empty Mediawiki Database and User
    * [Wiki Article](https://www.bonusbits.com/wiki/Reference:Secure_Mediawiki_Nginx_Configuration)
* EFS Mount Storage Created
    * [Example Template](https://github.com/bonusbits/cloudformation_templates/blob/master/infrastructure/nat-gateway.yml)
* Internet Access from EC2 Instance
    * [Example NAT Gateway Template](https://github.com/bonusbits/cloudformation_templates/blob/master/infrastructure/nat-gateway.yml)
    * [Example VPN BGP Template](https://github.com/bonusbits/cloudformation_templates/blob/master/infrastructure/vpn-bgp.yml)
    * [Example Sophos UTM 9 Template](https://github.com/bonusbits/cloudformation_templates/blob/master/infrastructure/utm9.yml)


# Launcher
Click this button to open AWS CloudFormation web console to enter parameters and create the stack.<br>
[![](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?#/stacks/new?&templateURL=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/cookbooks/bonusbits-mediawiki-nginx.yml)


# CloudFormation Template Details
The [CloudFormation Template](https://github.com/bonusbits/bonusbits_mediawiki_nginx/blob/master/cloudformation/bonusbits-mediawiki-nginx.yml)  the following:

1. Create Elastic Load Balancer v2 in public network (Optional)
    1. HTTP Listener
    2. HTTPS Listener
2. Autoscaling Group for Frontend Web Servers in private network
3. Adds the EC2 Instances to the appropriate security groups
4. Create own Security Group
5. Create IAM Instance Profile Role
4. Installs some basic packages needed for bootstrapping
    1. cfn-init
    2. aws-cfn-bootstrap
    3. cloud-init
5. Add DNS Update Script to Userdata (Optional)  
6. Setup and Execute Chef Zero
    1. Install Chef Client from internet
    2. Create Chef Configuration Files
    2. Download bonusbits_mediawiki_nginx cookbook from Github
    3. Triggers Chef Zero run

# Cookbook
1. Installs Latest Mediawiki
2. Add AWS API Access configurations
3. Starts Squid
4. Install and configure CloudWatch Logs Agent
5. Setup scripts and cron jobs to stream logs to CloudWatch Logs

# Tips
1. If needed the instance size can be increased.
2. Optionally you could add an ELB and scale past one, but I designed it to be an affordable easy solution. 