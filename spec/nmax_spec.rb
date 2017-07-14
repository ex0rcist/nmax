require 'spec_helper'

RSpec.describe Nmax do
  context 'with dummy file' do
    let(:io) { Nmax::IO.new(File.open('spec/fixtures/dummy.txt'), 1024 * 4) }

    it 'returns array of numbers' do
      expect(counter(5).numbers).to eq([623_648_676, 65_953_302, 9_543_284, 8_895_382, 8_443_462])
    end
  end

  context 'with passed input' do
    let(:io) { Nmax::IO.new(StringIO.new('abc123 hello world 45.6 99problems 10s'), 2) }

    it 'returns array of numbers' do
      expect(counter(5).numbers).to eq([123, 99, 45, 10, 6])
    end

    it 'returns correct amount of numbers' do
      expect(counter(4).numbers).to eq([123, 99, 45, 10])
    end
  end

  context 'args check' do
    it 'raises message if n is not numeric or less than 1' do
      expect(`echo 'abc123 hello world 45.6 99problems 10s' | nmax 0`).to eq("Usage: cat file.txt | nmax N\n")
    end

    it 'raises message if n is not numeric or less than 1' do
      expect(`echo 'abc123 hello world 45.6 99problems 10s' | nmax abs1`).to eq("Usage: cat file.txt | nmax N\n")
    end
  end
end

def counter(limit)
  Nmax::Counter.new(io, limit)
end
