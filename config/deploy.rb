set :user, "ubuntu"
set :application, "runpage"
set :repository,  "https://github.com/noguchi999/runpage.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "ec2-54-248-19-30.ap-northeast-1.compute.amazonaws.com"                  # Your HTTP server, Apache/etc
role :app, "ec2-54-248-19-30.ap-northeast-1.compute.amazonaws.com"                  # This may be ethe same as your `Web` server
role :db,  "ec2-54-248-19-30.ap-northeast-1.compute.amazonaws.com", :primary => true # This is where Rails migrations will run

set :deploy_to, "/home/ubuntu/runpage"

ssh_options[:keys] = %w(~/.ssh/Prototype.pem)
ssh_options[:auth_methods] = %w(publickey)
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
