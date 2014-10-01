module Apis
  module IpInfo
    URL = 'http://ipinfo.io/'

    def get_ip_data(ip_address)
      url = "#{URL}#{ip_address}"
      url += (url.match(/\/$/) ? '' : '/') + 'json'
      # raw_json = get_data(url)
      response = HTTParty.get(url)
      @data = JSON.parse(response.body)
    end

    def get_lat_and_lon(ip_address = nil)
      ip_data = self.get_ip_data(ip_address.to_s)
      Hash[%w(lat lon).zip(ip_data['loc'].split(','))]
    end

    def last_request_ip
      @data['ip']
    end

    def last_request_city
      @data['city']
    end
  end
end
