require './lib/artist'

describe Artist do
  subject do
    attributes = { id: '2', name: 'Ansel Adams', born: '1902', died: '1984', country: 'United States' }
    Artist.new(attributes)
  end

  describe '#init' do
    it 'is an instance of a artist' do
      expect(subject).to be_an_instance_of Artist
    end

    it 'has an id' do
      expect(subject.id).to eql('2')
    end

    it 'has a name' do
      expect(subject.name).to eql('Ansel Adams')
    end

    it 'has a birth year' do
      expect(subject.born).to eql('1902')
    end

    it 'has a year of death' do
      expect(subject.died).to eql('1984')
    end

    it 'has a country' do
      expect(subject.country).to eql('United States')
    end
  end

  describe '#age_at_death' do
    it 'calculates age at death' do
      expect(subject.age_at_death).to eql(82)
    end
  end
end
