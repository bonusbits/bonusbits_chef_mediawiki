# Encoding: utf-8
require_relative 'helpers'

SimpleCov.start do
  add_filter '/vendor/'
  add_filter '/config/'
  add_filter '/spec/'
  add_filter '/db/'
  add_filter '/app/mailers/'
  add_filter '/app/helpers/'
  add_filter '/app/uploaders/'
end

if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM).nil?
  set :backend, :exec
  set :path, '/sbin:/usr/local/sbin:/bin:/usr/bin:$PATH'
else
  set :backend, :cmd
  set :os, family: 'windows'
end
