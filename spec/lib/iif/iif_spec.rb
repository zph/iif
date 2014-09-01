describe IIF::Parser do
  let(:subject) { IIF::Parser.new(content: content) }
  let(:sections) { subject.sections }

  describe '#sections' do
    it 'parses correct number of sections' do
      count = sections.count
      expect(count).to eq(9)
    end
  end

  describe '#custom_header?' do
    it 'handles custom_headers' do
      response = subject.custom_header?(sections[1])
      expect(response).to eq(true)
    end
  end

  describe '#section_types' do
    it 'iterates over all sections without error' do
      smoke_check = lambda do
        types = sections.map do |section|
          subject.sanitize_section(section)
        end
      end

      expect(smoke_check).not_to raise_error
    end
  end

  describe '#sanitize_sections' do
    it 'smoke check' do
      response = subject.sanitize_sections
      expect(response.any?(&:nil?)).to eq(false)
    end
  end

  describe '#sanitize_section' do
    it 'parses section -4' do
      response = subject.sanitize_section(sections[-4])
      expect(response.class).to eq(Hash)
    end
  end

end

describe IIF::Section::SingleLine do
  let(:subject) do
    sec = parser.sections.first
    IIF::Section::SingleLine.new(content: sec)
  end

  let(:output) { subject.extract }

  describe '#extract' do
    it 'is a hash' do
      expect(output.class).to eq(Hash)
    end

    it 'has correct key' do
      expect(output.keys).to eq([:ACCNT])
    end
  end
end

describe IIF::Section::SingleLineCustom do
  let(:subject) do
    sec = parser.sections[1]
    IIF::Section::SingleLineCustom.new(content: sec)
  end

  let(:output) { subject.extract }

  describe '#extract' do
    it 'is a hash' do
      expect(output.class).to eq(Hash)
    end

    it 'has correct key' do
      expect(output.keys).to eq([:CUSTITEMDICT])
    end
  end
end
