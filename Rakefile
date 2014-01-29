require 'mobilize-base/tasks'
require 'mobilize-ssh/tasks'
require 'mobilize-hdfs/tasks'
require 'mobilize-hive/tasks'

namespace :mobilize do
  desc "Start a Resque worker"
  task :work, :env do |t,args|
    ENV['MOBILIZE_ENV']=args.env
    require 'mobilize-base'
    Mobilize::Base.config('jobtracker')['extensions'].each do |e|
      begin
        require e
      rescue Exception=>exc
        #do nothing
      end
    end
    Resque.redis = Redis.new host:     'mobilize-redis.8jph2h.0001.usw1.cache.amazonaws.com',
                             port:     6379
    begin
      worker = Resque::Worker.new(Mobilize::Resque.config['queue_name'])
    rescue Resque::NoQueueError
      abort "set QUEUE env var, e.g. $ QUEUE=critical,high rake resque:work"
    end

    puts "Starting worker #{worker}"

    worker.work(ENV['INTERVAL'] || 5) # interval, will block
  end
end
