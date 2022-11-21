class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  # default from: ENV['KEY']
  layout 'mailer'
end
