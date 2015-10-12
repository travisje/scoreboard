class Situation
  attr_accessor :outs_text, :base_runners_text
  
  def initialize(args)
    @outs_text = args["outsText"]
    @base_runners_text = args["baseRunnersText"]
  end

end