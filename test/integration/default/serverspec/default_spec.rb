# Encoding: utf-8

require_relative 'spec_helper'

describe 'terraform::default' do
  describe command('terraform -v') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /Terraform v0.4.2/ }
  end

  describe file('/usr/local/terraform-0.4.2') do
    it { should be_owned_by 'root' }
  end

  describe file('/usr/local/terraform') do
    it { should be_linked_to '/usr/local/terraform-0.4.2' }
    it { should be_owned_by 'root' }
  end

  describe file('/usr/local/bin/terraform') do
    it { should be_linked_to '/usr/local/terraform-0.4.2/terraform' }
    it { should be_owned_by 'root' }
    it { should be_executable }
  end
end
