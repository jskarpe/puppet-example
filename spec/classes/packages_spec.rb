require 'spec_helper'

# Nodes may be running one of two versions of Ubuntu - 10.04 or 10.10.
describe 'packages', :type => 'class' do
  context "On an unknown OS" do
    let :facts do
      {
        :operatingsystem => 'RedHat'
      }
    end

    it {
      expect { should raise_error(Puppet::Error) }
    }
  end

  #  firefox - make sure the version is 10.0.2+build1-0ubuntu0.10.04.1 (for Ubuntu 10.04 nodes), or
  #  10.0.2+build1-0ubuntu0.10.10.1 (for Ubuntu 10.10 nodes).
  #  mysql-server - ensure latest version is installed
  #  mysql-client - ensure latest version is installed
  #  openjdk-6-jre - ensure latest version is installed
  #  sun-java6-jre - ensure this package is NOT installed
  context "On Ubuntu 10.04" do
    let :facts do
      {
        :operatingsystem => 'Ubuntu',
        :operatingsystemrelease => '10.04'
      }
    end

    it {
      should contain_package('firefox').with( {
        'name' => 'firefox',
        'ensure' => '10.0.2+build1-0ubuntu0.10.04.1'
      } )
      should contain_package('mysql-server').with( { 'name' => 'mysql-server', 'ensure' => 'latest' } )
      should contain_package('mysql-client').with( { 'name' => 'mysql-client', 'ensure' => 'latest' } )
      should contain_package('openjdk-6-jre').with( { 'name' => 'openjdk-6-jre', 'ensure' => 'latest' } )
      should contain_package('sun-java6-jre').with( { 'name' => 'sun-java6-jre', 'ensure' => 'absent' } )
    }

    it {
      # Ensure correct package version is installed PRIOR to putting it on hold
      should contain_exec('hold-firefox-version').with({
        'command' => 'apt-mark hold firefox',
        'require' => 'Package[firefox]'
      })
    }
  end

  context "On Ubuntu 10.10" do
    let :facts do
      {
        :operatingsystem => 'Ubuntu',
        :operatingsystemrelease => '10.10'
      }
    end

    it {
      should contain_package('firefox').with( {
        'name' => 'firefox',
        'ensure' => '10.0.2+build1-0ubuntu0.10.10.1'
      } )
      should contain_package('mysql-server').with( { 'name' => 'mysql-server', 'ensure' => 'latest' } )
      should contain_package('mysql-client').with( { 'name' => 'mysql-client', 'ensure' => 'latest' } )
      should contain_package('openjdk-6-jre').with( { 'name' => 'openjdk-6-jre', 'ensure' => 'latest' } )
      should contain_package('sun-java6-jre').with( { 'name' => 'sun-java6-jre', 'ensure' => 'absent' } )
    }
  end
end
