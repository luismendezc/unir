# InSpec test for recipe apache_php::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/
# test/integration/default/default_test.rb

describe package('apache2') do
  it { should be_installed }
end

describe service('apache2') do
  it { should be_enabled }
  it { should be_running }
end

describe package('php') do
  it { should be_installed }
end

describe package('libapache2-mod-php') do
  it { should be_installed }
end

describe file('/var/www/html/index.html') do
  it { should_not exist }  # Tu receta elimina index.html
end

describe file('/var/www/html/index.php') do
  it { should exist }
  its('content') { should match /phpinfo/ }
end
