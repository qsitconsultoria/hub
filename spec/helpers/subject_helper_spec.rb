require 'spec_helper'

describe SubjectHelper do
  describe '.padded_number(number)' do
    context 'when number is < 10' do
      it 'pads with 0' do
        expect(padded_number(1)).to eql '01'
      end
    end

    context 'when number is >= 10' do
      it 'returns the number' do
        expect(padded_number(10)).to eql '10'
      end
    end
  end
end