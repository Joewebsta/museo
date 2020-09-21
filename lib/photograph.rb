class Photograph
  attr_reader :id,
              :name,
              :artist_id,
              :year

  def initialize(arguments)
    @id        = arguments[:id]
    @name      = arguments[:name]
    @artist_id = arguments[:artist_id]
    @year      = arguments[:year]
  end
end
