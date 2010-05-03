class Mailer < ActionMailer::Base

  def sites_down(body)
    recipients "jtmkrueger@gmail.com"
    from       "john@x-cr.com"
    subject    "SITE(S) FAIL"

    body        " #{body}"        
  end
end