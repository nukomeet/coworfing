=begin
require 'bundler/capistrano'
#require 'hipchat/capistrano'

server 'nukomeet', :web, :app

set :application, 'coworfing'
set :user, 'deployer'
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

set :scm, "git"
set :repository, "git@github.com:nukomeet/#{application}.git"
set :branch, "master"

# -- HipChat Integration

#set :hipchat_token, ENV['HIPCHAT_TOKEN']
#set :hipchat_room_name, "56513"
#set :hipchat_announce, false
#set :hipchat_human, "Zaiste!"

# if server requests something via IO
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
=end

require 'mina/git'
require 'mina/rbenv'
require 'mina/bundler'
require 'mina/rails'

set :term_mode, :system
set :app, 'coworfing'
set :user, 'deployer'
set :domain, '88.198.68.40'
set :deploy_to, "/home/#{user}/apps/#{app}"
set :repository, "git@github.com:nukomeet/#{app}.git"
set :shared_paths, ['config/database.yml']

desc "Deploys the current version to the server."
  task :config do
    queue "sudo ln -nfs #{deploy_to}/#{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{app}"
    queue "sudo ln -nfs #{deploy_to}/#{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{app}"
    queue "mkdir -p #{deploy_to}/#{shared_path}/config"
    queue "cp #{deploy_to}/#{current_path}/config/database.example.yml #{deploy_to}/#{shared_path}/config/database.yml"
  end

  task :environment do
    invoke :'rbenv:load'
  end

  task :deploy => :environment do
    deploy do
      invoke :'git:clone'
      invoke :'bundle:install'
      invoke :'deploy:link_shared_paths'
      invoke :config
      #invoke :'rails:db_migrate'
      #invoke :'rails:assets_precompile'

      to :launch do
        invoke :restart
      end
    end
end

task :start do
  queue "/etc/init.d/unicorn_#{app} start"
end

task :restart do
  queue "/etc/init.d/unicorn_#{app} restart"
end

task :stop do
  queue "/etc/init.d/unicorn_#{app} stop"
end

task :logs do
  queue %[cd #{deploy_to}/current && forever logs app.coffee]
end
