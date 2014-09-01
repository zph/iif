# describe IIF::Parser do
#   let(:subject) { IIF::Parser.new(content: content) }
#   let(:sections) { subject.sections }

#   describe '#sections' do
#     it 'parses correct number of sections' do
#       count = sections.count
#       expect(count).to eq(9)
#     end
#   end

#   describe '#custom_header?' do
#     it 'handles custom_headers' do
#       response = subject.custom_header?(sections[1])
#       expect(response).to eq(true)
#     end
#   end

#   describe 'multi_line_header?' do
#     it 'handles multi_line_header' do
#       content = File.read('fixtures/transactions.iif')
#       subject = IIF::Parser.new(content: content)
#       response = subject.multi_line_header?(content)
#       expect(response).to eq(true)
#     end
#   end

#   describe '#section_types' do
#     it 'iterates over all sections without error' do
#       smoke_check = lambda do
#         types = sections.map do |section|
#           subject.sanitize_section(section)
#         end
#       end

#       expect(smoke_check).not_to raise_error
#     end
#   end

#   describe '#sanitize_sections' do
#     it 'smoke check' do
#       response = subject.sanitize_sections
#       expect(response.any?(&:nil?)).to eq(false)
#     end
#   end

#   describe '#sanitize_section' do
#     it 'parses section -4' do
#       response = subject.sanitize_section(sections[-4])
#       expect(response.class).to eq(Hash)
#     end
#   end

# end

# describe IIF::Section::SingleLine do
#   let(:subject) do
#     sec = parser.sections.first
#     IIF::Section::SingleLine.new(content: sec)
#   end

#   let(:output) { subject.extract }

#   describe '#extract' do
#     it 'is a hash' do
#       expect(output.class).to eq(Hash)
#     end

#     it 'has correct key' do
#       expect(output.keys).to eq([:ACCNT])
#     end
#   end
# end

# describe IIF::Section::SingleLineCustom do
#   let(:subject) do
#     sec = parser.sections[1]
#     IIF::Section::SingleLineCustom.new(content: sec)
#   end

#   let(:output) { subject.extract }

#   describe '#extract' do
#     it 'is a hash' do
#       expect(output.class).to eq(Hash)
#     end

#     it 'has correct key' do
#       expect(output.keys).to eq([:CUSTITEMDICT])
#     end
#   end
# end

# describe IIF::Section::MultiLine do
#   let(:subject) do
#     content = File.read(Dir["fixtures/transactions*"].first)
#     IIF::Section::MultiLine.new(content: content)
#   end

#   let(:output) { subject.extract }

#   describe '#extract' do
#     it 'is a hash' do
#       expect(output.class).to eq(Hash)
#     end

#     it 'has correct key' do
#       expect(output.keys).to eq([:TRNS, :SPL])
#     end

#   end
# end

describe 'Approvals specs' do
  describe 'transactions' do
    let(:subject) do
      content = File.read(Dir["fixtures/transactions*"].first)
      IIF::Parser.new(content: content)
    end

    it 'contains only one section' do
      count = subject.sections.count
      expect(count).to eq(1)
    end

    it 'parses transactions data' do
      verify do
        IIF::Section::MultiLine.new(content: subject.sections.join).extract
      end
    end
  end

  # describe 'mixed transactions' do
  #   let(:subject) do
  #     content = File.read(Dir["fixtures/import*"].first)
  #     IIF::Parser.new(content: content)
  #   end

  #   it 'parses transactions data' do
  #     verify do
  #       subject.sanitize_sections
  #     end
  #   end
  # end
end
