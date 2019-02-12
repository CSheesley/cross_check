class GameRepo < StatTracker
  attr_reader :repo, :parent
  def initialize(filename, parent)
    contents = CSV.open filename, headers: true, header_converters: :symbol
    @repo = contents.map do |row|
      Game.new(row,self)
    end
    @parent = parent
  end
end
