set :stage, :production
set :whenever_environment, 'production'
set :rails_env, "production"

set :rvm_custom_path, '/usr/local/rvm/'

# Replace 127.0.0.1 with your server's IP address!
server '188.226.193.84', user: 'root', roles: %w{web app}
