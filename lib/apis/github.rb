module Apis
  module Github
    AUTHORIZE_URL = 'https://github.com/login/oauth/authorize'

    # See https://developer.github.com/v3/oauth/#web-application-flow
    # 1.step
    def generate_authorize_url(user, options={})
      options[:state] = user.generate_github_state! unless options.has_key?(:state)
      options[:client_id] = ENV['GITHUB_CLIENT_ID']
      "#{AUTHORIZE_URL}?#{options.to_query}"
    end
  end
end