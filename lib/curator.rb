class Curator
  attr_reader :artists, :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_artist(artist)
    artists << artist
  end

  def add_photograph(photograph)
    photographs << photograph
  end

  def find_artist_by_id(id)
    artists.find { |artist| artist.id == id }
  end
end
