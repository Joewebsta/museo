require './lib/photograph'
require './lib/artist'
require 'csv'

class Curator
  attr_reader :artists,
              :photographs

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
      hash[artist] = photographs.select { |photo| photo.artist_id == artist.id }
    end
  end

  def artists_with_multiple_photographs
    photographs_by_artist.select { |_artist, photos| photos.count >= 2 }.keys.map(&:name)
  end

  def photographs_taken_by_artist_from(country)
    photographs.find_all do |photo|
      artist = find_artist_by_id(photo.artist_id)
      artist.country == country
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

  def photographs_taken_between(range)
    photographs.select { |photo| range.include?(photo.year.to_i) }
  end

  def artists_photographs_by_age(artist)
    artist_photos = photographs_by_artist[artist]
    artist_photos.each_with_object({}) do |photo, hash|
      artist_age = photo.year.to_i - artist.born.to_i
      hash[artist_age] = photo.name
    end
  end
end
