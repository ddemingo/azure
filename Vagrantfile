Vagrant.configure("2") do |config|

    config.vm.box = "peru/ubuntu-20.04-server-amd64"
    #config.vm.network :forwarded_port, guest: 80, host: 8080
    #config.vm.synced_folder ".", "/home/vagrant/host"
       
    config.vm.provider "virtualbox" do |vbox|
      vbox.name = "azure"
      vbox.memory = "4096"
      vbox.cpus = 2
    end
  
    config.vm.provision "shell", inline: <<-SHELL
      apt -y update
      apt -y install curl git python3-pip
    SHELL
    
end