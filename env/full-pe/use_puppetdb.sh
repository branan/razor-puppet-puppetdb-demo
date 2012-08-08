#!/bin/bash

cp /vagrant/puppet.conf /etc/puppetlabs/puppet/puppet.conf
/etc/init.d/pe-httpd restart
