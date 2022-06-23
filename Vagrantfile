Vagrant.configure("2") do |config|

    config.vm.box = "peru/ubuntu-20.04-server-amd64"
    #config.vm.network :forwarded_port, guest: 80, host: 8080
       
    config.vm.provider "virtualbox" do |vbox|
      vbox.name = "azure"
      vbox.memory = "4096"
      vbox.cpus = 2
    end
  
    config.vm.provision "shell", inline: <<-SHELL
      apt-get -y update
    SHELL
    
end