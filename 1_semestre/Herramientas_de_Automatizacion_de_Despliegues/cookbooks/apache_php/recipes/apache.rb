# Instala Apache
package 'apache2' do
    action :install
end

# Habilita y levanta el servicio de Apache
service 'apache2' do
    action [:enable, :start]
end
  
# Opcional: Elimina el index.html predeterminado
file '/var/www/html/index.html' do
    action :delete
end
  
  