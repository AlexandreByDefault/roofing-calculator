require "uri"
require "net/http"
require "json"
require 'googlestaticmap'

class BuildingsController < ApplicationController
  before_action :set_building, only: %i[show edit update destroy]

  def index
    @buildings = Building.all
  end

  def show
    @markers = {
      lat: @building.lat,
      lng: @building.lng
    }
  end

  def new
    @building = Building.new
  end

  def create
    @building = Building.new(set_params)
    client = OpenStreetMap::Client.new
    result = client.search(q: @building.address, format: 'json', addressdetails: '1', accept_language: 'fr')
    unless result.count.zero?
      @building.address = result[0]["display_name"]
      @building.lat = result[0]["lat"]
      @building.lng = result[0]["lon"]
      @building.ne_lat = result[0]["boundingbox"][0]  #min Longitude
      @building.ne_lng = result[0]["boundingbox"][2]  #min Latitude
      @building.sw_lat = result[0]["boundingbox"][1] #max Longitude
      @building.sw_lng = result[0]["boundingbox"][3] #max Latitude
    end
    if @building.save
      redirect_to building_path(@building)
    else
      redirect_to new_building_path
      flash.alert = "Address invalid"
    end
  end

  def edit
  end

  def update
    @building.update(set_params)
  end

  def destroy
    @building.delete
  end

  private

  def set_params
    params.require(:building).permit(:address, :lat, :lng, :ne_lng, :ne_lat, :sw_lat, :sw_lng, :surface, :nom)
  end

  def set_building
    @building = Building.find(params[:id])
  end

  def google_place_api
    @google_api = ENV['GOOGLE_PLACE_API']
  end

  def search_request(string)
    ascii_string = ActiveSupport::Inflector.transliterate(string)
    url = URI("https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=#{ascii_string}&inputtype=textquery&fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&key=#{google_place_api}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    response.read_body
    JSON.parse(response.read_body, object_class: Hash)
  end
end
