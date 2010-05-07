class Mailer < ActionMailer::Base

  def sites_down(body)
    recipients "#{ENV['RECIPIENT1']}, #{ENV['RECIPIENT2']}"
    from       "john@x-cr.com"
    subject    "SITE(S) FAIL"

    body        " #{body}"        
  end
end