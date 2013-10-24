require 'spec_helper'

describe 'virtualbox' do
  it do
    should contain_package('VirtualBox-4.3.0-89960').with({
      :ensure   => 'installed',
      :source   => 'http://download.virtualbox.org/virtualbox/4.3.0/VirtualBox-4.3.0-89960-OSX.dmg',
      :provider => 'pkgdmg',
      :require  => 'Exec[Kill Virtual Box Processes]',
    })

    should contain_exec('Kill Virtual Box Processes').with({
      :command      => 'pkill "VBoxXPCOMIPCD" || true && pkill "VBoxSVC" || true && pkill "VBoxHeadless" || true',
      :path         => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      :onlyif       => 'ps aux | grep "VBoxXPCOMIPCD\|VBoxSVC\|VBoxHeadless" | grep -v "grep"'
    })
  end
end
