class GameRepo < StatTracker
  attr_reader :games
  def initialize(parent)
    @repo = []
    contents = CSV.open './data/game_fixture.csv', headers: true, header_converters: :symbol
    contents.each do |row|
      @repo << Game.new(row)
    end
  end
end
