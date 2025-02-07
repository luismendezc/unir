# Instalar Java (requerido por Jenkins)
package 'openjdk-11-jdk' do
    action :install
end

# Instalar dependencias básicas que Jenkins necesita
package 'net-tools' do
    action :install
end

# Descargar el paquete .deb de Jenkins (versión estable elegida 2.387.2)
remote_file '/tmp/jenkins.deb' do
    source 'https://pkg.jenkins.io/debian-stable/binary/jenkins_2.387.2_all.deb'
    action :create
end

# Instalar Jenkins usando el archivo .deb
dpkg_package 'jenkins' do
    source '/tmp/jenkins.deb'
    action :install
end

# Iniciar y habilitar Jenkins
service 'jenkins' do
    action [:enable, :start]
end
