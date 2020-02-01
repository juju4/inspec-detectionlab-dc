# frozen_string_literal: true

domain_enabled = input('domain_enabled', value: true, description: 'Check Domain Controller role is configured')
domain2_enabled = input('domain2_enabled', value: false, description: 'Check Domain Controller role is active - post-reboot')

if domain_enabled
  title 'Server is domain controller'
  control 'domain-01' do
    title 'Files & directory'
    desc 'Ensure domain files and directories exist'
    describe file('C:\Windows\SYSVOL') do
      it { should be_directory }
    end
  end
  control 'domain-02' do
    title 'Windows Features'
    desc 'Ensure domain Windows Features are present'
    describe windows_feature('AD-Domain-Services') do
      it { should be_installed }
    end
  end
end

if domain2_enabled
  title 'Server is active domain controller'
  control 'domaindiag-01' do
    title 'Dcdiag'
    desc 'Ensure dcdiag returns no warnings or errors'
    describe command('dcdiag /e /v /c') do
      its('stdout') { should eq '/Directory Server Diagnosis:/' }
      its('stdout') { should eq '/Testing Server:/' }
      its('stdout') { should eq '/passed/' }
      its('stdout') { should_not eq '/Error/' }
      its('stdout') { should_not eq '/failed/' }
    end
  end
end
