# frozen_string_literal: true

gpos_check_enabled = input('gpos_check_enabled', value: true, description: 'Check if expected GPOs are configured')
gpos_list = input(
  'gpos_list',
  value: [
    'Custom Event Channel Permissions',
    'Default Domain Policy',
    'Default Domain Controllers Policy',
    'Disable Windows Defender',
    'Domain Controllers Enhanced Auditing Policy',
    'Powershell Logging',
    'Servers Enhanced Auditing Policy',
    'Windows Event Forwarding Server',
    'Workstations Enhanced Auditing Policy'
  ],
  description: 'list of expected GPOs'
)

if gpos_check_enabled
  title 'Active GPOs'
  control 'gpos-01' do
    title 'Get-GPO'
    desc 'Ensure expected GPOs are present'
    describe command('Get-GPO -All') do
      gpos_list.each do |str|
        its('stdout') { should match str }
      end
    end
  end
end
