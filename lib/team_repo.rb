class TeamRepo 
  attr_reader :repo, :parent

  def initialize(filename, parent)
    contents = CSV.open filename, headers: true, header_converters: :symbol
    @repo = contents.map do |row|
      Team.new(row, self)
    end
    @parent = parent
  end
end
