require "uri"
require "net/http"

class BuildingsController < ApplicationController
  before_action :params_id, only: %i[show create update destroy]

  def index
    @buildings = Building.all
    geometry
  end

  def show
  end

  def new
    @building = Building.new
  end

  def create
    @building = Building.new(set_params)
    @building.save!
  end

  def edit
  end

  def update
    @building.update(set_params)
  end

  def destroy
    @building.delete
  end

  def geometry
    @reponse = search_request("21 rue Lamartine")
  end

  private

  def set_params
    params.require(:building).permit(:address, :lat, :lng, :ne_lng, :ne_lat, :sw_lat, :sw_lng, :surface, :nom)
  end

  def params_id
    @building = Building.find(params[:id])
  end

  def google_place_api
    @google_api = ENV['GOOGLE_PLACE_API']
  end

  def search_request(string)
    url = URI("https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=#{string}&inputtype=textquery&fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&key=#{google_place_api}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    response.read_body
  end
end
