class GameRepo
  attr_reader :repo

  def initialize(filename)
    contents = CSV.open filename, headers: true, header_converters: :symbol
    @repo = contents.map do |row|
      Game.new(row)
    end
  end
end
