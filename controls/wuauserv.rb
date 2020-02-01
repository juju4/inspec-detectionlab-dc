# frozen_string_literal: true

wuauserv_active = input('wuauserv_active', value: true, description: 'Check Windows Update service is enabled')

if wuauserv_active
  title 'Win Updates service up'
  control 'wu-01' do
    describe service('wuauserv') do
      it { should be_installed }
      it { should be_running }
    end
  end
end
