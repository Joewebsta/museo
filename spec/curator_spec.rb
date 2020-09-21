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

  describe '#photographs_taken_by_artist_from' do
    before do
    end

    context 'when artists are from the provided country' do
      it 'returns an array of photos' do
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

        photos_array = [photo2, photo3, photo4]
        expect(subject.photographs_taken_by_artist_from('United States')).to eql(photos_array)
      end
    end

    context 'when artists are not from the provided country' do
      it 'returns an empty array' do
        expect(subject.photographs_taken_by_artist_from('Argentina')).to eql([])
      end
    end
  end

  describe '#load_photographs' do
    it 'populates photographs array' do
      subject.load_photographs('./data/photographs.csv')
      expect(subject.photographs.count).to eql(4)
    end
  end

  describe '#load_artists' do
    it 'populates artists array' do
      subject.load_artists('./data/artists.csv')
      expect(subject.artists.count).to eql(6)
    end
  end

  describe '#photographs_taken_between' do
    it 'returns an array of photographs created between two dates' do
      subject.load_artists('./data/artists.csv')
      subject.load_photographs('./data/photographs.csv')
      photo1 = subject.photographs[0]
      photo4 = subject.photographs[3]

      expect(subject.photographs_taken_between(1950..1965)).to eql([photo1, photo4])
    end
  end

  describe '#artists_photographs_by_age' do
    it 'returns a hash of artist ages and the photographs they took' do
      subject.load_artists('./data/artists.csv')
      subject.load_photographs('./data/photographs.csv')

      diane_arbus = subject.find_artist_by_id('3')
      hash = { 44 => 'Identical Twins, Roselle, New Jersey', 39 => 'Child with Toy Hand Grenade in Central Park' }

      expect(subject.artists_photographs_by_age(diane_arbus)).to eql(hash)
    end
  end
end
