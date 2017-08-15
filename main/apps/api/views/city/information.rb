module Api::Views::City
  class Information
    include Api::View
    format :json

    def render
      raw JSON.generate(city)
    end
  end
end
