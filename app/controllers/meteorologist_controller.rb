require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    urlm = "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"
    
    parsed_datam = JSON.parse(open(urlm).read)

    latm = parsed_datam["results"][0]["geometry"]["location"]["lat"]

    lngm = parsed_datam["results"][0]["geometry"]["location"]["lng"] 

    urlf = "https://api.forecast.io/forecast/0aa57b84821ba837319e7139219885f2/#{latm},#{lngm}"

    parsed_dataf = JSON.parse(open(urlf).read)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    @current_temperature = parsed_dataf["currently"]["temperature"]

    @current_summary = parsed_dataf["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_dataf["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_dataf["hourly"]["summary"]

    @summary_of_next_several_days = parsed_dataf["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
