class GameRepo < StatTracker
  attr_reader :repo, :parent
  def initialize(filename, parent)
    @repo = []
    contents = CSV.open filename, headers: true, header_converters: :symbol
    contents.each do |row|
      @repo << Game.new(row)
    end
    @parent = parent
  end
end
