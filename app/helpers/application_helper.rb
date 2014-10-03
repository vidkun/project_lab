module ApplicationHelper
  include Apis::IpInfo
  include Apis::Github

  def get_weather_widget(request)
    ip = request.remote_ip unless request.remote_ip == '127.0.0.1'
    lat_and_lon = get_lat_and_lon(ip)
    lat_and_lon.merge!(name: last_request_city || ip || last_request_ip)
    iframe_src = 'http://forecast.io/embed/#' + lat_and_lon.to_query
    html = '<iframe id="forecast_embed" type="text/html" frameborder="0" height="245" width="100%" src="' + iframe_src + '"> </iframe>'
    raw html
  end

  def github_authorize_button()
    link_to "Link To Github", generate_authorize_url(current_user, redirect_uri: github_callback_url()), class: 'btn btn-primary'
  end
end
