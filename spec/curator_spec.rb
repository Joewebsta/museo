require './lib/curator'

describe Curator do
  subject { Curator.new }

  describe '#init' do
    it 'is an instance of Curator' do
      expect(subject).to be_an_instance_of Curator
    end

    it 'has no photographs' do
      expect(subject.photographs).to eql([])
    end

    it 'has no artists' do
      expect(subject.artists).to eql([])
    end
  end

  describe '#add_artists' do
    it 'adds artists to the artists array' do
      artist1 = Artist.new({ id: '1', name: 'Henri Cartier-Bresson', born: '1908', died: '2004', country: 'France' })
      artist2 = Artist.new({ id: '2', name: 'Ansel Adams', born: '1902', died: '1984', country: 'United States' })
      subject.add_artist(artist1)
      subject.add_artist(artist2)

      expect(subject.artists).to eql([artist1, artist2])
    end
  end

  describe '#add_photographs' do
    it 'adds photographs to the photographs array' do
      photo1 = Photograph.new({ id: '1', name: 'Rue Mouffetard, Paris (Boy with Bottles)', artist_id: '1', year: '1954' })
      photo2 = Photograph.new({ id: '2', name: 'Moonrise, Hernandez', artist_id: '2', year: '1941' })
      subject.add_photograph(photo1)
      subject.add_photograph(photo2)

      expect(subject.photographs).to eql([photo1, photo2])
    end
  end

  describe '#find_artist_by_id' do
    it 'finds artist by id' do
      artist1 = Artist.new({ id: '1', name: 'Henri Cartier-Bresson', born: '1908', died: '2004', country: 'France' })
      subject.add_artist(artist1)

      expect(subject.find_artist_by_id('1')).to eql(artist1)
    end
  end

  describe '#photographs_by_artist' do
    it 'returns a hash of artists and their photographs' do
      artist1 = Artist.new({ id: '1', name: 'Henri Cartier-Bresson', born: '1908', died: '2004', country: 'France' })
      artist2 = Artist.new({ id: '2', name: 'Ansel Adams', born: '1902', died: '1984', country: 'United States' })
      artist3 = Artist.new({ id: '3', name: 'Diane Arbus', born: '1923', died: '1971', country: 'United States' })
      subject.add_artist(artist1)
      subject.add_artist(artist2)
      subject.add_artist(artist3)

      photo1 = Photograph.new({ id: '1', name: 'Rue Mouffetard, Paris (Boy with Bottles)', artist_id: '1', year: '1954' })
      photo2 = Photograph.new({ id: '2', name: 'Moonrise, Hernandez', artist_id: '2', year: '1941' })
      photo3 = Photograph.new({ id: '3', name: 'Identical Twins, Roselle, New Jersey', artist_id: '3', year: '1967' })
      photo4 = Photograph.new({ id: '4', name: 'Monolith, The Face of Half Dome', artist_id: '3', year: '1927' })
      subject.add_photograph(photo1)
      subject.add_photograph(photo2)
      subject.add_photograph(photo3)
      subject.add_photograph(photo4)

      hash = {
        artist1.name => [photo1],
        artist2.name => [photo2],
        artist3.name => [photo3, photo4]
      }

      expect(subject.photographs_by_artist).to eql(hash)
    end
  end

  describe '#artists_with_multiple_photographs' do
    it 'returns and array of artist names who have multiple photos' do
      artist1 = Artist.new({ id: '1', name: 'Henri Cartier-Bresson', born: '1908', died: '2004', country: 'France' })
      artist3 = Artist.new({ id: '3', name: 'Diane Arbus', born: '1923', died: '1971', country: 'United States' })
      subject.add_artist(artist1)
      subject.add_artist(artist3)

      photo1 = Photograph.new({ id: '1', name: 'Rue Mouffetard, Paris (Boy with Bottles)', artist_id: '1', year: '1954' })
      photo3 = Photograph.new({ id: '3', name: 'Identical Twins, Roselle, New Jersey', artist_id: '3', year: '1967' })
      photo4 = Photograph.new({ id: '4', name: 'Monolith, The Face of Half Dome', artist_id: '3', year: '1927' })
      subject.add_photograph(photo1)
      subject.add_photograph(photo3)
      subject.add_photograph(photo4)

      expect(subject.artists_with_multiple_photographs).to eql(['Diane Arbus'])
    end
  end
end
