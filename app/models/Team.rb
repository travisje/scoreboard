class Team
  attr_accessor :id, :name, :location, :record, :color, :abbreviation
  
  def initialize(args)
    @id = args["id"]
    @name = args["name"]
    @location = args["location"]
    @color = args["color"]
    @record = args["record"]["summary"]
    @abbreviation = args["abbreviation"]
  end



end