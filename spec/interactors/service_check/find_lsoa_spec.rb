# frozen_string_literal: true

require 'rails_helper'

describe ServiceCheck::FindLsoa do
  subject(:context) { described_class.call(postcode:) }

  before do
    expect(Postcodes::Factory).to receive(:create).with(postcode:).and_return(postcode_lookup)
  end

  describe '.call' do
    context 'successful postcode lookup' do
      let(:postcode) { 'SE1 7QD' }
      let(:postcode_lookup) do
        result = double(:result, { postcode:, lsoa: 'Southwark 034A' })

        double(:postcode_lookup, { ok?: true, result: })
      end

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'returns the lsoa' do
        expect(context.lsoa).to eq('Southwark 034A')
      end

      it 'returns the orginal postcode' do
        expect(context.postcode).to eq('SE1 7QD')
      end
    end
  end

  context 'postcode not found' do
    let(:postcode) { 'SH24 1AA' }
    let(:postcode_lookup) do
      double(:postcode_lookup, { ok?: false, not_found?: true })
    end

    it 'succeeds' do
      expect(context).to be_a_success
    end

    it 'returns not_found' do
      expect(context.not_found).to be_truthy
    end

    it 'returns the orginal postcode' do
      expect(context.postcode).to eq('SH24 1AA')
    end
  end

  context 'postcode is invalid' do
    let(:postcode) { 'SE1' }
    let(:postcode_lookup) do
      double(:postcode_lookup, { ok?: false, not_found?: false, invalid?: true, error_message: 'The error message' })
    end

    it 'fails' do
      expect(context).to be_a_failure
    end

    it 'provides a failure message' do
      expect(context.message).to be_present
    end

    it 'returns the orginal postcode' do
      expect(context.postcode).to eq('SE1')
    end
  end
end
