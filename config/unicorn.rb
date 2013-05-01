worker_processes 4
working_directory "/home/deployer/apps/coworfing/current"

listen "/tmp/coworfing.unicorn.sock.0", :backlog => 64
listen "/tmp/coworfing.unicorn.sock.1", :backlog => 64

timeout 30

pid "/home/deployer/apps/coworfing/tmp/unicorn.pid"

stderr_path "/home/deployer/apps/coworfing/current/log/unicorn.stderr.log"
stdout_path "/home/deployer/apps/coworfing/current/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end