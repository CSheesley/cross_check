class GameTeamRepo
  attr_reader :repo

  def initialize(filename)
    contents = CSV.open filename, headers: true, header_converters: :symbol
    @repo    = contents.map { |row| GameTeam.new(row) }
  end
end
