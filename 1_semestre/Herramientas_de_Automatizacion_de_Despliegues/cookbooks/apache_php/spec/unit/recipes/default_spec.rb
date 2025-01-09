#
# Cookbook:: apache_php
# Spec:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'apache_php::default' do
  context 'En Ubuntu 20.04' do
    let(:chef_run) do
      # Simula un run de Chef en Ubuntu 20.04
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '20.04')
                          .converge(described_recipe)
    end

    # Verifica la instalación de Apache
    it 'instala el paquete apache2' do
      expect(chef_run).to install_package('apache2')
    end

    # Verifica que habilita y arranca el servicio de Apache
    it 'habilita y arranca el servicio apache2' do
      expect(chef_run).to enable_service('apache2')
      expect(chef_run).to start_service('apache2')
    end

    #  Verifica que elimina el index.html si existe
    it 'elimina el index.html por defecto' do
      expect(chef_run).to delete_file('/var/www/html/index.html')
    end

    #  Verifica la instalación de PHP
    it 'instala el paquete php' do
      expect(chef_run).to install_package('php')
    end

    it 'instala el paquete libapache2-mod-php' do
      expect(chef_run).to install_package('libapache2-mod-php')
    end

    # Verifica que reinicia apache2 tras instalar mod-php
    it 'reinicia el servicio apache2' do
      expect(chef_run).to restart_service('apache2')
    end

    # Verifica que crea el archivo index.php con phpinfo()
    it 'crea el archivo /var/www/html/index.php con contenido phpinfo()' do
      expect(chef_run).to create_file('/var/www/html/index.php')
        .with_content('<?php phpinfo(); ?>')
    end
  end
end
