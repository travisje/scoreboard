class Game
  attr_accessor :id, :status, :date_time, :home_team, :away_team, :home_starting_pitcher, :away_starting_pitcher, :winning_pitcher, :losing_pitcher, :saving_pitcher, :home_team_score, :away_team_score, :situation, :status_detail, :venue, :links

  def self.import_json
    file = File.read('app/assets/javascripts/mlb.json')
    @@data_hash = JSON.parse(file)
  end

  def initialize
    @@all << self  
  end

  def self.initialize
    @@all = []
    Player.initialize
  end

  def self.events_array
    @@data_hash["sports"][0]["leagues"][0]["events"]
  end

  def self.buildgames
    Game.initialize
    import_json
    events_array.each do |event|
      game = Game.new
      game.venue = Venue.new(event["venues"][0])
      game.links = event["links"]["web"]
      competition = event["competitions"][0]
      game.id = competition["id"]
      game.date_time = Time.parse(competition["date"])
      game.status = competition["status"]["description"]
      game.status_detail = competition["status"]["detail"]
      competition["competitors"].each do |competitor|
        if competitor["homeAway"] == "home"
          game.home_team = Team.new(competitor["team"])
          game.home_team_score = competitor["score"]
        elsif competitor["homeAway"] == "away"
          game.away_team = Team.new(competitor["team"])
          game.away_team_score = competitor["score"]
        end
      end
      game.home_starting_pitcher = Player.new(competition["stats"]["homeStartingPitcher"]["athlete"])
      game.away_starting_pitcher = Player.new(competition["stats"]["awayStartingPitcher"]["athlete"])
      if competition["stats"]["winningPitcher"]
        game.winning_pitcher = Player.find_or_new_by(competition["stats"]["winningPitcher"]["athlete"])
      end
      if competition["stats"]["losingPitcher"]
        game.losing_pitcher = Player.find_or_new_by(competition["stats"]["losingPitcher"]["athlete"])
      end
      if competition["stats"]["savingPitcher"]
        game.saving_pitcher = Player.find_or_new_by(competition["stats"]["savingPitcher"]["athlete"])
      end
      if competition["situation"]
        game.situation = Situation.new(competition["situation"])
      end
    end
  end

  def self.all
    @@all
  end

  def home_team_winner?
    if (status == "FINAL") && (home_team_score.to_i > away_team_score.to_i)
      true
    else
      false
    end
  end

  def away_team_winner?
    if (status == "FINAL") && (home_team_score.to_i < away_team_score.to_i)
      true
    else
      false
    end
  end

end