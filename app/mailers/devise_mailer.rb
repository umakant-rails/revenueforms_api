class DeviseMailer < Devise::Mailer
  default from: Rails.application.secrets.email
  before_action :set_host_name
  
  def confirmation_instructions(record, token, opts={})
    mail = super
    mail.subject = "Revenueforms.com Account Confirmation"
    mail
  end

  def reset_password_instructions(record, token, opts={})
    mail = super
    mail.subject = "Revenueforms.com Reset New Password"
    mail
  end

  private 

  def set_host_name
    @host_name = Rails.application.config.action_mailer.default_url_options[:host]
  end
end