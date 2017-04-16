# Bonusbits Base
default['bonusbits_base']['cloudwatch_logs']['logs_group_name'] = 'kitchen-bonusbits-mediawiki-nginx'

# If not an EC2 Instance will blow up with null values from Ohai EC2 plugin
if node['bonusbits_base']['aws']['inside']
  default['bonusbits_base']['cloudwatch_logs']['additional_logs'] = [
    '[nginx-access]',
    "log_group_name = #{node['bonusbits_base']['cloudwatch_logs']['logs_group_name']}",
    "log_stream_name = #{node['ec2']['instance_id']}-nginx-access",
    'datetime = %d/%b/%Y:%H:%M:%S',
    'file = /var/log/nginx/access.log',
    '',
    '[nginx-errors]',
    "log_group_name = #{node['bonusbits_base']['cloudwatch_logs']['logs_group_name']}",
    "log_stream_name = #{node['ec2']['instance_id']}-nginx-errors",
    'datetime = %Y/%m/%d %H:%M:%S',
    'file = /var/log/nginx/error.log',
    '',
    '[php-fpm-errors]',
    "log_group_name = #{node['bonusbits_base']['cloudwatch_logs']['logs_group_name']}",
    "log_stream_name = #{node['ec2']['instance_id']}-php-fpm-errors",
    'datetime = %d-%b-%Y %H:%M:%S',
    'file = /var/log/php-fpm/7.0/error.log',
    '',
    '[php-fpm-www-errors]',
    "log_group_name = #{node['bonusbits_base']['cloudwatch_logs']['logs_group_name']}",
    "log_stream_name = #{node['ec2']['instance_id']}-php-fpm-www-errors",
    'datetime = %d-%b-%Y %H:%M:%S',
    'file = /var/log/php-fpm/7.0/www-error.log',
    '',
    '[mediawiki-debug]',
    "log_group_name = #{node['bonusbits_base']['cloudwatch_logs']['logs_group_name']}",
    "log_stream_name = #{node['ec2']['instance_id']}-mediawiki-debug",
    'file = /var/log/mediawiki/debug.log'
  ]
end
