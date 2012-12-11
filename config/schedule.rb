# Use this file to easily define all of your cron jobs.
#
set :output, "#{path}/log/schedule.log"
#
job_type :rake, "cd #{path} && MOBILIZE_ENV=:environment bundle exec rake :task --silent :output"
#make sure workers stay current and available
every 10.minutes do
  rake "mobilize_base:kill_idle_and_stale_workers"
  rake "mobilize_base:prep_workers"
end
#

# this file uses the whenever gem to generate cron jobs
# Learn more: http://github.com/javan/whenever