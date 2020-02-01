# frozen_string_literal: true

domain_enabled = input('domain_enabled', value: true, description: 'Check Domain Controller role is configured')

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
