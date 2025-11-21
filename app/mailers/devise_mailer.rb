class DeviseMailer < Devise::Mailer
  default from: Rails.application.secrets.email
  before_action :set_host_name
  
  def confirmation_instructions(record, token, opts={})
    # mail = super
    # mail.subject = "Revenueforms.com Account Confirmation"
    # mail
    url = Rails.application.secrets.zeptomail_url
    secret_token = Rails.application.secrets.zeptomail_secret_token
    host = default_url_options[:host]
    mailer = Devise::Mailer.new

    html_string = mailer.render_to_string(
      template: "users/mailer/confirmation_instructions",
      formats: [:html],
      assigns: {
        host_name: "#{host}",
        resource: record,
        token: record.reset_password_token,
        opts: { from: "no-reply@yourapp.com" }
      }
    )

    payload = {
      from: { address: "admin@revenueforms.com", name: "<noreply>"},
      to: [
        { email_address: { address: record.email, name: record.username } }
      ],
      subject: "Verify Your Email to Activate Your Account",
      htmlbody: html_string
    }

    response = ZeptoMailClient.send_mail(url, secret_token, payload)
  end

  def reset_password_instructions(record, token, opts={})
    url = Rails.application.secrets.zeptomail_url
    secret_token = Rails.application.secrets.zeptomail_secret_token
    host = default_url_options[:host]
    mailer = Devise::Mailer.new

    html_string = mailer.render_to_string(
      template: "users/mailer/reset_password_instructions",
      formats: [:html],
      assigns: {
        host_name: "#{host}",
        resource: record,
        token: record.reset_password_token,
        opts: { from: "no-reply@yourapp.com" }
      }
    )

    payload = {
      from: { address: "admin@revenueforms.com", name: "<noreply>"},
      to: [
        { email_address: { address: record.email, name: record.username } }
      ],
      subject: "Reset Your Account Password",
      htmlbody: html_string
    }

    response = ZeptoMailClient.send_mail(url, secret_token, payload)

    # mail = super
    # mail.subject = "Revenueforms.com Reset New Password"
    # mail
  end

  private 

  def set_host_name
    @host_name = Rails.application.config.action_mailer.default_url_options[:host]
  end
end