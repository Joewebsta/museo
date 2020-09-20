require './lib/photograph'

describe Photograph do
  subject do
    attributes = { id: '1', name: 'Rue Mouffetard, Paris (Boy with Bottles)', artist_id: '4', year: '1954' }
    Photograph.new(attributes)
  end

  describe '#init' do
    it 'is an instance of a photograph' do
      expect(subject).to be_an_instance_of Photograph
    end

    it 'has an id' do
      expect(subject.id).to eql('1')
    end

    it 'has a name' do
      expect(subject.name).to eql('Rue Mouffetard, Paris (Boy with Bottles)')
    end

    it 'has an artist id' do
      expect(subject.artist_id).to eql('4')
    end

    it 'has a year' do
      expect(subject.year).to eql('1954')
    end
  end
end
