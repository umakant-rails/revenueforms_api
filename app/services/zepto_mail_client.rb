class ZeptoMailClient
  include HTTParty

  def initialize(url:, token:)
    @url = url
    @token = token
  end

  def self.send_mail(url, token, payload)
    headers = {
      "Content-Type"  => "application/json",
      "Accept"        => "application/json",
      "Authorization" => token
    }

    post(url, headers: headers, body: payload.to_json)
  end
end
