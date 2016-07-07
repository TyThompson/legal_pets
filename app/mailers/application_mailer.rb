class ApplicationMailer < ActionMailer::Base
  default from: "admin@legal-pets.herokuapp.com"
  layout 'mailer'
end
