class GameRepo < StatTracker
  attr_reader :repo
  def initialize
    @repo = []
    contents = CSV.open './data/game_fixture.csv', headers: true, header_converters: :symbol
    contents.each do |row|
      @repo << Game.new(row)
    end
  end
end
