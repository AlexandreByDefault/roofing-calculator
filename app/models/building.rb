class Building < ApplicationRecord

  validates :address, :lat, :lng, presence: true
  geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?

  def diagonal
  distance([ne_lat, ne_lng],[sw_lat, sw_lng])
  end

  def surface
    (diagonal * diagonal) / 2
  end

  private

  def distance(loc1, loc2)
    rad_per_deg = Math::PI / 180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters

    dlat_rad = (loc2[0]- loc1[0]) * rad_per_deg  # Delta, converted to rad

    dlon_rad = (loc2[1] - loc1[1]) * rad_per_deg

    lat1_rad, lon1_rad = loc1.map { |i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map { |i| i * rad_per_deg }

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1 - a))

    rm * c # Delta in meters

  end
end
