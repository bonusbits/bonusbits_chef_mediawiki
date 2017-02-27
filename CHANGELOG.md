##CHANGE LOG
---

##0.6.0 - 02/26/2016 - Levon Becker - [Issue 1](https://github.com/bonusbits/bonusbits_mediawiki_nginx/issues/1)
* Added VectorTemplate cookbook template
* Added minerva.mustache cookbook template. Turned out to be a better and easier location to simply drop the Google AdSense HTML under the header section for Mobile Frontend.
* AdSense Code converted to a single line with ruby command ```ruby -e 'p ARGF.read' mobile_responsive.html``` and then added to a data bag item JSON. 

##0.5.0 - 02/18/2016 - Levon Becker
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
