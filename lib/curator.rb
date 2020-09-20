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

  def photographs_by_artist
    artists.each_with_object({}) do |artist, hash|
      hash[artist.name] = photographs.select { |photo| photo.artist_id == artist.id }
    end
  end
end
