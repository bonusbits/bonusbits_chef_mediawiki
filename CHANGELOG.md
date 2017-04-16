##CHANGE LOG
---

## 1.2.1 - 04/15/2017 - Levon Becker
* Added Berksfile.lock to lock in the tested dependant cookbooks versions.

## 1.2.0 - 04/15/2017 - Levon Becker - [Issue 24](https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues/24)
* Moved nodeinfo to /usr/local/bin/
* Added kitchen docker configure that works with amazonlinux image
* Added ECS CloudFormation Template
* Added dokken kitchen config
* Merged all kitchen configs into default (.kitchen.yml)
* Add ECS Agent recipe, environment, tests (I like installing instead of using baked Amazon AMI, because at companies they usually have hardened AMIs you have to use and can't usually use 3rd party AMIs)
* Added Dockerfile and dockerignore. The Dockerfile can make an image using the cookbook that can be uploaded to a registry. Plan is to use this or logic in CircleCI to build image and upload to ECR
* Switched to InSpec Profile Integration Tests to practice DRY
* Renamed environments to have _dev on end for if I want to auto determine settings based on environment name
* Switch detected environment back to node.environment (I wish they would make up their minds and just leave it)
* Split yum_cron to it's own recipe
* Changed package_list to web_package_list and moved to default recipe
* Renamed attribute optional_packages_list to base_packages_list and moved to default recipe
* Deleted packages recipe
* Added 'packages' key to packages lists
* Fixed yum-cron-hourly template resource to use correct template file
* Renamed templates/default/base to templates/default/node_info and moved yum-cron and awslogs.conf templates under web
* Added CloudWatch Logs /var/log/chef-client.log stream
* CFN: Added Client.rb chef client logging to client.rb **/var/log/chef-client.log**
* CFN: Removed role since just calling the recipe for run list and change chef run to call the recipe instead.
* Switched to new bonusbits_base cloudwatch_logs way to only need to pass additional log stream content.
* Added some conditions to kitchen for environment and data bag so if local or CI/other etc.
* CFN: Renamed "install_chef_client" to "install_chefdk"
* Added condition on additional logs attribute so doesn't try to set if not in AWS because EC2 Ohai plugin will blow up with null values

## 1.0.7 - 03/19/2017 - Levon Becker
* Added Inspec Tests for All recipes
* Made adsense comments for sidebars all the same style
* Set vim to vim-enhanced
* Fixed Sudoers sed command

## 1.0.6 - 03/17/2017 - Levon Becker
* Moved attributes out of default to own matching attributes file. Easier to add/remove functions and find attributes I'm looking for.
* Added Sendmail recipe call, but nothing in it yet.
* Removed Code Climate. Really that's good for like a Ruby Gem. Not so much for a cookbook. Especially because I'm not going to write rspec tests.

## 1.0.5 - 03/16/2017 - Levon Becker
* Added cfn-init.log and cfn-init-cmd.log to Cloudwatch Logs Stream

## 1.0.4 - 03/16/2017 - Levon Becker - [Issue 2](https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues/2)
* Cleaned up default recipe, data bag and environment files that still had backup settings
* Removed backup parameters from cloudformation template.

## 1.0.3 - 03/16/2017 - Levon Becker - [Issue 2](https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues/2)
* Dropped backup script drafts. Going to Data Pipeline backup solution.

## 1.0.2 - 03/12/2017 - Levon Becker - [Issue 5](https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues/5) & [Issue 11](https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues/11) & [Issue 17](https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues/17)
* Dropped Sidebar Ads from 5 to 3 matching ad units plus small, medium then large progression. updated data bag sidebar php
* Fixed dns attribute overrides needed in environment file for test kitchen
* Changed update-dns script to generate the upsert json in /tmp directory instead of /opt/chef-repo
* Re-arranged Ruby Blocks to only output error and strout if errors
* Added two not_if blocks to the php-fpm folder chowns
* Enabled AutoScaling Group Metric Collection in CloudFormation Template
* Added CPU Alert to Autoscaling group
* Added Notifications to Autoscaling Group
* Added Metrics Collection to Autoscaling Group

## 1.0.1 - 03/11/2017 - Levon Becker - [Issue 14](https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues/14) & [Issue 16](https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues/16)
* Added Symlink for sitemap.xml to EFS (uploads). So that it's shared among the frontend servers.
* Fixed Issue 16 updating search engines of changes
    ```
    PHP Warning:  fopen(https://www.google.com/webmasters/sitemaps/ping?sitemap=/sitemap.xml): failed to open stream: HTTP request failed! HTTP/1.0 400 Bad Request
        in /var/www/html/mediawiki/extensions/AutoSitemap/AutoSitemap_body.php on line 231
    ```
* Added Data Bag Item Parameter to CloudFormation
* Moved encrypted data bag item to git so there is inherent versioning
* Removed S3 Deploy Bucket parameter as it's no longer needed since Data Bag Items included with cookbook
* Added logic in CloudFormation to copy the data bags + data bag items to /opt/chef-repo/data_bags/
* Renamed Data Bag since it's no longer generic and static strings use in CloudFormation cfn-init
* Added CookbookName parameter to CloudFormation. Mostly to make code more easily reusable

## 1.0.0 - 03/07/2017 - Levon Becker
* Initial Stable Release

## 0.8.0 - 03/06/2017 - Levon Becker - [Issue 4](https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues/4)
* First Draft done of CloudFormation
* Moved a lot of values out of environment file to data bag. That way less parameters for CloudFormation.
* Split up Attributes a little more.
* Updated example environment and data bag jsons to match new logic.

## 0.7.0 - 03/04/2017 - Levon Becker - [Issue 8](https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues/8)
* Added Fixed for News Extension to display Hyperlinks with whitespaces instead of underscores.
* Organized the templates directory. It was getting out of control and harder to find what I was looking for.

## 0.6.0 - 02/26/2017 - Levon Becker - [Issue 1](https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues/1)
* Added VectorTemplate cookbook template
* Added minerva.mustache cookbook template. Turned out to be a better and easier location to simply drop the Google AdSense HTML under the header section for Mobile Frontend.
* AdSense Code converted to a single line with ruby command ```ruby -e 'p ARGF.read' mobile_responsive.html``` and then added to a data bag item JSON. 

## 0.5.0 - 02/18/2017 - Levon Becker
* Updated NodeInfo script naming
* Updated Node Info Script to include Mediawiki outputs
* Parametrized uploads/images folder so easy to change around. Including updating Nginx config
* Parametrized x-forwarding so it's optional in the Nginx config Template
* Parametrized /wiki alias rewrite so it's optional in the Nginx config Template
* Added EFS Mount/Fstab update
* Added Log Rotate config for Mediawiki logs
* Created /var/log/mediawiki folder for Mediawiki logs such as debug and backups. Not Nginx access/error though
* Add network backlogs config for in Nginx recipe
* Added /usr/local/bin to sudoers secure_path for pip upgrade (moves binary location)
* Added upgrade pip to 9.x
* Added ngxtop python script
* Finished writing out the LocalSettings template and associated default attributes.
* Moved desktop and mobile logo png files to EFS share and changed logic so don't need to download from S3
* Moved favicon.ico to EFS share and added Symlink to root of web site
* Moved nft-utils from default packages to the EFS recipe
* Added more conditions to ruby blocks to make no-op if already completed task
* Renamed debug log from mediawiki.log to /var/log/mediawiki/debug.log
* Fixed and made consistent Localsetting Mediawiki varible calls to have {} around 
* Switched HideNamespace and AutoSitmap extensions to pull from github repos I created under Bonus Bits org.
