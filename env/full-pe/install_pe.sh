#!/bin/bash

TMPDIR=/var/tmp
DIR=`mktemp -d`

gem uninstall puppet -a -x 
gem uninstall facter -a -x

pushd $DIR
cat >> answers <<EOF
q_install=y
q_puppet_cloud_install=n
q_puppet_enterpriseconsole_auth_database_name=console_auth
q_puppet_enterpriseconsole_auth_database_password=lTWDqbK4IAWxYRQaugme
q_puppet_enterpriseconsole_auth_database_user=console_auth
q_puppet_enterpriseconsole_auth_password=password
q_puppet_enterpriseconsole_auth_user_email=admin@example.com
q_puppet_enterpriseconsole_database_install=y
q_puppet_enterpriseconsole_database_name=console
q_puppet_enterpriseconsole_database_password=9LyyE70GcYcdXvQiT2lD
q_puppet_enterpriseconsole_database_remote=n
q_puppet_enterpriseconsole_database_root_password=rdm1szgvWLtZzKRZWdv0
q_puppet_enterpriseconsole_database_user=console
q_puppet_enterpriseconsole_httpd_port=443
q_puppet_enterpriseconsole_install=y
q_puppet_enterpriseconsole_inventory_hostname=master.puppetlabs.vm
q_puppet_enterpriseconsole_inventory_port=8140
q_puppet_enterpriseconsole_master_hostname=master.puppetlabs.vm
q_puppet_enterpriseconsole_smtp_host=localhost
q_puppet_enterpriseconsole_smtp_password=
q_puppet_enterpriseconsole_smtp_port=25
q_puppet_enterpriseconsole_smtp_use_tls=n
q_puppet_enterpriseconsole_smtp_user_auth=n
q_puppet_enterpriseconsole_smtp_username=
q_puppet_symlinks_install=y
q_puppetagent_certname=master.puppetlabs.vm
q_puppetagent_install=y
q_puppetagent_server=master.puppetlabs.vm
q_puppetca_install=y
q_puppetmaster_certname=master.puppetlabs.vm
q_puppetmaster_dnsaltnames=master,master.puppetlabs.vm,puppet,puppet.puppetlabs.vm
q_puppetmaster_enterpriseconsole_hostname=localhost
q_puppetmaster_enterpriseconsole_port=443
q_puppetmaster_forward_facts=n
q_puppetmaster_install=y
q_vendor_packages_install=y
EOF
cat answers
tar xf /vagrant/puppet-enterprise-2.5.3-ubuntu-12.04-amd64.tar.gz
cd puppet-enterprise-2.5.3-ubuntu-12.04-amd64
./puppet-enterprise-installer -a ../answers
cd ..
wget http://apt-enterprise.puppetlabs.com/puppetlabs-enterprise-release-extras_1.0-2_all.deb

# Enable the PE-extras repository
dpkg -i puppetlabs-enterprise-release-extras_1.0-2_all.deb
apt-get update
popd
rm -rf $DIR

# Enable autosigning
echo '*' > /etc/puppetlabs/puppet/autosign.conf
