module Apis
  module Github
    include HTTParty # https://github.com/jnunemaker/httparty

    AUTHORIZE_URL          = 'https://github.com/login/oauth/authorize'
    ACCESS_TOKEN_URL       = 'https://github.com/login/oauth/access_token'
    AUTHENTICATED_USER_URL = 'https://api.github.com/user' #https://developer.github.com/v3/users/#get-the-authenticated-user

    # See https://developer.github.com/v3/oauth/#web-application-flow
    # 1.step
    def generate_authorize_url(user, options={})
      options[:state] = user.generate_github_state! unless options.has_key?(:state)
      options[:client_id] = ENV['GITHUB_CLIENT_ID']
      options[:redirect_uri] = options[:redirect_uri] || github_callback_path()
      "#{AUTHORIZE_URL}?#{options.to_query}"
    end

    # See https://developer.github.com/v3/oauth/#web-application-flow
    # 2.step
    def self.get_access_token(user, code, redirect_url=nil)
      self.headers 'Accept' => 'application/json'
      params = {
        :code => code,
        :client_id => ENV['GITHUB_CLIENT_ID'],
        :client_secret => ENV['GITHUB_CLIENT_SECRET'],
        # :redirect_uri => redirect_url
      }
      response = self.post(ACCESS_TOKEN_URL, :query => params)
      response['access_token']
    end

    # https://developer.github.com/v3/#authentication
    def self.get_user_information(user)
      self.headers 'Authorization' => "token #{user.github_access_token}", 'User-Agent' => Rails.application.class.parent_name
          # self.headers 'Accept' => 'application/json'
      response = self.get(AUTHENTICATED_USER_URL)
      response['login']
    end
  end
end