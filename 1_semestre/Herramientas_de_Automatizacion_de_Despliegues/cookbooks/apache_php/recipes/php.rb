# Actualizar apt
execute 'apt_update' do
  command 'apt-get update'
  action :run
end

# Instala PHP y el módulo Apache para interpretar PHP
package 'php' do
  action :install
end

package 'libapache2-mod-php' do
  action :install
end

# Reinicia Apache para reconocer PHP
service 'apache2' do
  action :restart
end

# Crea un index.php con una página php sencilla
file '/var/www/html/index.php' do
  content '<?php phpinfo(); ?>'
  action :create
end

