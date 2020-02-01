# frozen_string_literal: true

osquery_enabled = input('osquery_enabled', value: true, description: 'Check Osquery is configured')

if osquery_enabled
  title 'Osquery'
  control 'osquery-01' do
    title 'Osquery configuration'
    desc 'Osquery is configured'
    describe file('C:\Program Files\osquery\osquery.conf') do
      it { should be_file }
    end
    describe file('C:\Program Files\osquery\osquery.flags') do
      it { should be_file }
    end
    describe file('C:\Program Files\osquery\packs\osquery-windows-pack.conf') do
      it { should be_file }
    end
    describe file('C:\Program Files\osquery\osqueryi.exe') do
      it { should be_file }
    end
    describe file('C:\Program Files\osquery\osquery.db') do
      it { should be_directory }
    end
  end
  control 'osquery-02' do
    title 'Osquery service'
    desc 'Osquery service is configured and running'
    describe service('osquery daemon service') do
      it { should be_installed }
      it { should be_running }
    end
  end
end
