# coding:utf-8
# unicron.rb
worker_processes 4 
working_directory '/home/ubuntu/runpage/current/'

listen '/tmp/sockets/unicorn_headwaters.sock', :backlog => 1
listen 4422, :tcp_nopush => true

pid '/home/ubuntu/runpage/current/tmp/pids/unicorn_headwaters.pid'

timeout 10

stdout_path '/home/ubuntu/runpage/current/log/unicorn.stdout.log'
stderr_path '/home/ubuntu/runpage/current/log/unicorn.stderr.log'

preload_app  true
GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
     sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  sleep 1
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
