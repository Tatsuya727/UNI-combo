class ApplicationMailer < ActionMailer::Base
  default from: "user@noreply.com"
  layout "mailer"
end
