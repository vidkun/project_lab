module ApplicationHelper
  include Apis::IpInfo

  def get_weather_widget(request)
    ip = request.remote_ip unless request.remote_ip == "127.0.0.1"
    lat_and_lon = get_lat_and_lon(ip)
    lat_and_lon.merge!(name: get_last_request_city || ip || get_last_request_ip() )
    iframe_src = 'http://forecast.io/embed/#'+lat_and_lon.to_query
    html = '<iframe id="forecast_embed" type="text/html" frameborder="0" height="245" width="100%" src="'+iframe_src+'"> </iframe>'
    raw html
  end
end
