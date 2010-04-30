#!/usr/bin/ruby
#change line above to reference your ruby location
 
require 'rubygems'
require 'net/smtp'
require 'mysql'
require 'time'
require 'curb'
require 'action_mailer'
require 'ping'

class Mailer < ActionMailer::Base

  def sites_down(body)
    recipients "jtmkrueger@gmail.com"
    from       "john@x-cr.com"
    subject    "SITE(S) FAIL"

    body        " #{body}"        
  end
end

# Mailer.template_root = File.dirname(__FILE__)
Mailer.delivery_method = :sendmail
Mailer.logger = Logger.new(STDOUT)



 
def check
     @time = nil
 
    # Connect to db that stores all of our sites to monitor
     db = Mysql::new("localhost","root","","simpleserver")
 
	# Make sure we are only looking at sites that are active
    sites = db.query("SELECT * FROM sites WHERE active = 1")
	# Getting the most recent report since we only want to run the script to send a report every 2 hours
    last_report = db.query("SELECT * FROM reports WHERE fixed = 0 ORDER BY sent_at DESC Limit 0,1")
    last_report.each {|r| @time = r[1]}
		# If there isn't a report in the database yet it sets the time to greater than 2 hours so the script will run and report if needed.
        if @time.nil?
         @diff = 7201
        else
		# Calculating the difference in time
         @report = Time.parse(@time)
         @now = Time.now
         @diff = @now - @report
        end
			# Change this number to whatever you would prefer in seconds. Currently it is 2 hours
        unless @diff.to_i < 7200
            body = ""
            sites_down = 0
            pings_down = 0
            broke_sites = ""
 
            sites.each do |s|
              
              puts s.inspect
				# Prints the site name to the user
                print s[1]
				# need a begin/rescue in case the domain can't be curled
                begin
				# Uses curb to curl the domain
                 c = Curl::Easy.perform(s[2])
                puts " - #{c.response_code}"
 
			   # check http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html for examples of response codes
                unless c.response_code < 399
					# reports to the screen when manually ran that the site is down
                      puts "--DOWN--"
					  #increments the number of sites down and writes to the body of the email
                      sites_down = sites_down + 1
                      broke_sites = broke_sites + "#{s[2]},\n"
                      body = body + "DOWN - #{s[2]}\n"
               end
 
                rescue
				# if the script is unable to curl the site we still mark it as down since we want to make sure we are in good shape
                    sites_down = sites_down + 1
                    broke_sites = broke_sites + "#{s[2]},\n"
                    body = body + s[1] + " unable to curl, check record in db and ensure that it is being pointed. "
                        puts "--DOWN--"
                end
 
                #only send if sites are down
               if Ping.pingecho("#{s[2]}", 10) == true
                 puts "#{s[2]} ping sucessful"
               else
                 pings_down = pings_down + 1
                 broke_sites = broke_sites + "#{s[2]},\n"
                 body = body + s[1] + " unable to ping, go take a look at this. "
               end
                
 
            end
 
            if sites_down > 0 or pings_down > 0
                #send text and email
                record_report = db.query("INSERT INTO reports(down, sent_at, fixed, broke_sites, body) VALUES(#{sites_down}, now(), 0, '#{broke_sites}', '#{body}')")
                # this sends the email
                Mailer.deliver_sites_down(body)
            end
         else
			# Since there is still a report that is in the db that was recorded less than 2 hours ago we just want to notify the user if running it from shell.
            puts "Please run 'update-reports.rb' first and then 'simple-server-check.rb' again, OR go mark your reports as fixed in the rails app."
            puts "You are seeing this message because there is a report that hasn't been marked as fixed within the past 2 hours."
         end
end

#need to run the function
check