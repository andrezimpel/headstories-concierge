set :application, 'headstories_concierge'
set :repo_url, 'git@github.com:andrezimpel/headstories-concierge.git'

# whenever
# set :whenever_command, "bundle exec whenever"
# set :whenever_environment, -> { rails_env }
# set :whenever_identifier, -> { "#{application}_production" }
# require "whenever/capistrano"

# delayed job
# require "delayed/recipes"

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# set :deploy_to, '/var/www/my_app'
set :deploy_to, '/var/www/concierge.headstories.de' # production
# set :scm, :git

# user
set :use_sudo, true

set :rvm_ruby_version, '2.1.3'
set :rvm_type, :user

set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_dirs, [
  "log",
  "restricted",
  "public/system",
  "tmp/cache",
  "tmp/pids",
  "tmp/sockets",
  "tmp/uploads",
  "public/uploads",
  # "tmp/uploads/cache",
  # "tmp/uploads/store",
  "vendor/bundle",
]


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # execute 'bundle'
      # execute 'rake db:migrate'
      # invoke 'solr:restart'
    end
  end

  after :restart, :restart_passenger do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :touch, 'tmp/restart.txt'
      end
    end
  end


  after :finishing, 'deploy:restart_passenger'
  after :finishing, 'deploy:cleanup'
end
