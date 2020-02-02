ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'
Vagrant.require_version '>= 1.5'

Vagrant.configure('2') do |config|
  name = File.basename(Dir.getwd) + '-dev'

  config.vm.box = 'joshfng/railsbox'
  config.ssh.forward_agent = true
  config.vm.hostname = name

  config.vm.synced_folder '.', '/vagrant'

  config.vm.provider :virtualbox do |v|
    v.name = name
    v.memory = 2048
    v.cpus = 2
    v.customize [
      'modifyvm', :id,
      '--nictype1', 'virtio',
      '--name', name,
      '--natdnshostresolver1', 'on'
    ]
    v.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 5000 ]
  end

  # rails
  config.vm.network 'forwarded_port', guest: 3000, host: 8083
end
