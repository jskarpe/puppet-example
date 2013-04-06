require 'spec_helper'

# Nodes may be running one of two versions of Ubuntu - 10.04 or 10.10.
describe 'timezone', :type => 'class' do
  context "With timezone data package" do
    it {
      should contain_package('tzdata')
    }
  end
end

describe 'timezone::utc', :type => 'class' do
  it { should include_class('timezone') }
  it {
    should contain_file("/etc/localtime").with( { 'source' => 'file:///usr/share/zoneinfo/UTC', 'require' => 'Package[tzdata]' } )
  }
end

describe 'timezone::gmt', :type => 'class' do
  it { should include_class('timezone') }
  it {
    should contain_file("/etc/localtime").with( { 'source' => 'file:///usr/share/zoneinfo/GMT', 'require' => 'Package[tzdata]' } )
  }
end