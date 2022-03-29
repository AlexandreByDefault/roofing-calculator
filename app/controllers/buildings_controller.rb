require "uri"
require "net/http"
require "json"

class BuildingsController < ApplicationController
  before_action :set_building, only: %i[show edit update destroy]

  def index
    @buildings = Building.all
  end

  def show
  end

  def new
    @building = Building.new
  end

  def create
    @building = Building.new(set_params)
    if @building.save
      result = search_request(@building.address)
      @building.lat = result['candidates'][0]['geometry']['location']['lat']
      @building.lng = result['candidates'][0]['geometry']['location']['lng']
      @building.ne_lat = result['candidates'][0]['geometry']['viewport']['northeast']['lat']
      @building.ne_lng = result['candidates'][0]['geometry']['viewport']['northeast']['lng']
      @building.sw_lat = result['candidates'][0]['geometry']['viewport']['southwest']['lat']
      @building.sw_lng = result['candidates'][0]['geometry']['viewport']['southwest']['lng']
      @building.save
    else
      render :new
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
