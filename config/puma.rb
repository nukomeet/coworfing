rails_env = ENV['RAILS_ENV'] || 'development'

threads 4,4

root = "/home/deployer/apps/coworfing"

bind  "unix:///tmp/puma-coworfing.sock"
pidfile "#{root}/tmp/puma/pid"
state_path "#{root}/tmp/puma/state"

activate_control_app
