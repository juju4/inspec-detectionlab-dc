# frozen_string_literal: true

detectionlab_setup = input('detectionlab_setup', value: true, description: 'Check Detectionlab files and registries are present')

if detectionlab_setup
  title 'DetectionLab files & configuration'
  control 'detectionlab-01' do
    describe file('C:\DetectionLab') do
      it { should be_directory }
    end
    describe file('C:\Program Files\Classic Shell\ClassicStartMenu.exe') do
      it { should be_file }
    end
    describe file('C:\Program Files\Wireshark\Wireshark.exe') do
      it { should be_file }
    end
    describe file('C:\ProgramData\chocolatey\lib\sysinternals\tools\accesschk64.exe') do
      it { should be_file }
    end
    describe file('c:\program files\notepad++\notepad++.exe') do
      it { should be_file }
    end
    describe file('C:\windows\system32\drivers\etc\hosts') do
      it { should be_file }
    end
    describe file('c:\Tools\Mimikatz\README.md') do
      it { should be_file }
    end
    describe file('c:\Tools\Atomic Red Team\atomic-red-team-master\README.md') do
      it { should be_file }
    end
    describe file('c:\windows\System32\WindowsPowerShell\v1.0\Modules\Microsoft.PowerShell_profile.ps1') do
      it { should be_file }
    end
  end
  control 'detectionlab-02' do
    title 'AutoLogon'
    desc 'AutoLogon is configured'
    describe registry_key('HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon') do
      its('AutoAdminLogon') { should eq 1 }
      its('DefaultUserName') { should eq 'vagrant' }
    end
  end
  control 'detectionlab-03' do
    title 'IPv6'
    desc 'IPv6 is disabled'
    describe registry_key('HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters') do
      its('DisabledComponents') { should eq 255 }
    end
  end
end
