task :cron => :environment do
 if Time.now.hour % 1 == 0 # run every hour
   SimpleServerCheck.run_checks
 end