module Apis
  module IpInfo

    URL = 'http://ipinfo.io/'

    def get_ip_data(ip_address)
      url = "#{URL}#{ip_address}"
      url += (url.match(/\/$/) ? '' : '/') + 'json'
      raw_json = get_data(url)
      @data = JSON.parse(raw_json)
    end

    def get_lat_and_lon(ip_address=nil)
      ip_data = self.get_ip_data(ip_address.to_s)
      Hash[["lat", 'lon'].zip(ip_data['loc'].split(','))]
    end

    def get_last_request_ip()
      @data['ip']
    end

    def get_last_request_city()
      @data['city']
    end

    private
    # ex. get_url("http://ipinfo.io/json")
    def get_data(url)
      uri = URI.parse(url)
      Net::HTTP.get(uri)
    end
  end
end
