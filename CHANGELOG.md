##CHANGE LOG
---

##1.0.1 - 03/11/2017 - Levon Becker - [Issue 14](https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues/14) & [Issue 16](https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues/16)
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

##1.0.0 - 03/07/2017 - Levon Becker
* Initial Stable Release

##0.8.0 - 03/06/2017 - Levon Becker - [Issue 4](https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues/4)
* First Draft done of CloudFormation
* Moved a lot of values out of environment file to data bag. That way less parameters for CloudFormation.
* Split up Attributes a little more.
* Updated example environment and data bag jsons to match new logic.

##0.7.0 - 03/04/2017 - Levon Becker - [Issue 8](https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues/8)
* Added Fixed for News Extension to display Hyperlinks with whitespaces instead of underscores.
* Organized the templates directory. It was getting out of control and harder to find what I was looking for.

##0.6.0 - 02/26/2017 - Levon Becker - [Issue 1](https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues/1)
* Added VectorTemplate cookbook template
* Added minerva.mustache cookbook template. Turned out to be a better and easier location to simply drop the Google AdSense HTML under the header section for Mobile Frontend.
* AdSense Code converted to a single line with ruby command ```ruby -e 'p ARGF.read' mobile_responsive.html``` and then added to a data bag item JSON. 

##0.5.0 - 02/18/2017 - Levon Becker
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
