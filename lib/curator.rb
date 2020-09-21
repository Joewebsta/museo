require './lib/photograph'
require './lib/artist'
require 'csv'

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

  def artists_with_multiple_photographs
    photographs_by_artist.select { |_artist, photos| photos.count >= 2 }.keys
  end

  def photographs_taken_by_artist_from(country)
    artist_ids = artists.select { |artist| artist.country == country }.map(&:id)

    photographs.each_with_object([]) do |photograph, array|
      array << photograph if artist_ids.include?(photograph.artist_id)
    end
  end

  def load_photographs(file)
    photo_data = CSV.read(file, headers: true, header_converters: :symbol)
    photo_data.each { |photo| add_photograph(Photograph.new(photo)) }
  end

  def load_artists(file)
    artist_data = CSV.read(file, headers: true, header_converters: :symbol)
    artist_data.each { |artist| add_artist(Artist.new(artist)) }
  end
end
