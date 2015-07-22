require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    urlw = "https://api.forecast.io/forecast/0aa57b84821ba837319e7139219885f2/#{@lat+","+@lng}"
    parsed_dataw = JSON.parse(open(urlw).read)

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================



    @current_temperature = parsed_dataw["currently"]["temperature"]

    @current_summary = parsed_dataw["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_dataw["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_dataw["hourly"]["summary"]

    @summary_of_next_several_days = parsed_dataw["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
