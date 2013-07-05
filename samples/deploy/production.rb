role :app, "production.host.com"
set :whenever_environment, 'production'
after "deploy:update_code" do
  bundler.bundle_new_release
  config.populate_dirs
  whenever.update_crontab
  resque.restart_resque_web
end
