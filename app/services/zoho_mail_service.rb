require 'httparty'
require 'json'

class ZohoMailService
  ZOHO_TOKEN_URL = 'https://accounts.zoho.com/oauth/v2/token'
  ZOHO_MAIL_API  = 'https://mail.zoho.com/api/accounts'

  FROM_EMAIL = Rails.application.secrets.email
  CLIENT_ID     = Rails.application.secrets.client_id
  CLIENT_SECRET = Rails.application.secrets.client_secret
  REFRESH_TOKEN = ''
  ACCOUNT_ID    = Rails.application.secrets.account_id

  # Get a new access token using refresh token
  def self.get_access_tokennnnnnnnnnnn
    response = HTTParty.post(
      ZOHO_TOKEN_URL,
      query: {
        refresh_token: REFRESH_TOKEN,
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        grant_type: 'refresh_token'
      }
    )
    JSON.parse(response.body)['access_token']
  end
  
  def self.access_token
    # 1. If we already have a token AND it's not expired → reuse it
    return @access_token if @access_token && Time.now < @token_expiry

    # 2. Else: hit Zoho API using the refresh token to get a new access token
    response = HTTParty.post(
      "https://accounts.zoho.com/oauth/v2/token",
      query: {
        refresh_token: REFRESH_TOKEN,
        client_id: ZOHO_CLIENT_ID,
        client_secret: ZOHO_CLIENT_SECRET,
        grant_type: "refresh_token"
      }
    )

    # 3. Save it in memory
    data = JSON.parse(response.body)
    @access_token = data["access_token"]

    # 4. Store expiration time (access token lasts 3600 seconds)
    @token_expiry = Time.now + 3500  # buffer for safety

    # 5. Return that access token
    @access_token
  end


  # Send email
  def self.send_email(to:, subject:, content:)
    access_token = get_access_token
    url = "#{ZOHO_MAIL_API}/#{ACCOUNT_ID}/messages"
    
    puts "_____________________________________________"
    puts access_token
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    puts url
    puts "_____________________________________________"
    puts access_token
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    body = {
      fromAddress: FROM_EMAIL,
      toAddress: to,
      subject: subject,
      content: content
    }

    headers = {
      'Authorization' => "Zoho-oauthtoken #{access_token}",
      'Content-Type' => 'application/json'
    }

    response = HTTParty.post(url, headers: headers, body: body.to_json)
    puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
    puts response
    JSON.parse(response.body)
  end
end

