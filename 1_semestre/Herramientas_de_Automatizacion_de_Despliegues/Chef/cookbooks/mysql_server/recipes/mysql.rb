# Instala MySQL Server
package 'mysql-server' do
    action :install
end

# Activa el servicio
service 'mysql' do
    action [:enable, :start]
end

# Ajustamos la configuración para escuchar en 0.0.0.0  
cookbook_file '/etc/mysql/mysql.conf.d/mysqld.cnf' do
    source 'mysqld.cnf'   
    owner 'root'
    group 'root'
    mode '0644'
    notifies :restart, 'service[mysql]', :immediately
end

# Crear el usuario remoto
execute 'create_remote_user' do
    command <<-EOF
        mysql -u root -e "CREATE USER IF NOT EXISTS 'myuser'@'%' IDENTIFIED BY 'mypassword';
                        GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%' WITH GRANT OPTION;
                        FLUSH PRIVILEGES;"
    EOF
    action :run
end

# Crear la base de datos
execute 'create_db' do
    command 'mysql -u root -e "CREATE DATABASE IF NOT EXISTS mydatabase"'
    action :run
end
