class Venue
  attr_accessor :name, :city, :state
  
  def initialize(args)
    @name = args["name"]
    @city = args["city"]
    @state = args["state"]
  end

end