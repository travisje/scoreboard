class Player
  attr_accessor :id, :first_name, :last_name
  
  @@all = []
  def initialize(args)
    @id = args["id"]
    @first_name = args["firstName"]
    @last_name = args["lastName"]
    @@all << self
  end

  def self.initialize
    @@all = []
  end

  def self.all
    @@all
  end

  def self.find_or_new_by(args)
    result = nil
    self.all.each do |player|
      if player.id == args["id"]
        result = player
      end
    end
    result || Player.new(args)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def picture_url(width=90, height=67)
    "http://a.espncdn.com/combiner/i?img=/i/headshots/mlb/players/full/#{id}.png?w=#{width}&h=#{height}&scale=crop&transparent=true"
  end


end