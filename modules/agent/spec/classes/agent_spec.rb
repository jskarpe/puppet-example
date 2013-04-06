require 'spec_helper'

describe 'agent', :type => 'class' do

  # Nodes may be running one of two versions of Ubuntu - 10.04 or 10.10.
  context "Copy agent and agent.init from Puppet master to node" do
    it {
      #    1) Copy the file "agent.init" from the puppetmaster (you can assume whatever puppet:// path you wish) to /etc/init.d.
      #      Make sure it is owned by root and has appropriate privileges for an init script.
      should contain_file('agent.init').with( {
        'owner' => 'root',
        'mode' => '0755',
        'source' => "puppet:///agent/agent.init",
        'target' => "/etc/init.d/agent.init",
        'notify' => 'Service[agent]' # From 3)
      } )

      #  2) Copy the file "agent" from the puppetmaster to /usr/local/bin.
      # Make sure it is owned by root and has appropriate privileges for a binary executable.
      should contain_file('agent').with( {
        'source' => "puppet:///agent/agent",
        'target' => '/usr/local/bin/agent',
        'owner' => 'root',
        'mode' => '0755',
        'notify' => 'Service[agent]' # From 3)
      } )
    }
  end

  context "Ensure service is installed and runs" do
    it {
      #  3) Ensure that the "agent" service is running (started via executing agent.init).
      # Note that this service should be restarted any time a new version of agent.init or the agent binary itself is fetched.
      should contain_service('agent').with( {
        'name' => 'agent.init',
        'ensure' => 'running',
        'provider' => 'debian',
      } )
    }
  end

  context "Ensure that the timezone is set to UTC" do
    # 5) Ensure that the timezone is set to GMT/UTC.  This should ideally be done before the agent service starts.
    it { should include_class('timezone::utc') }
  end

end
