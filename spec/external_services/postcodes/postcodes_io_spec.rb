# frozen_string_literal: true

require 'rails_helper'

describe Postcodes::PostcodesIo, :vcr do
  subject { described_class.new(postcode:) }

  context 'postcode is valid' do
    # Arrange
    let(:result) { double(:result) }

    context 'postcode has correct spacing' do
      let(:postcode) { 'SE1 7QD' }

      it 'should return information about the given postcode' do
        expect(Postcodes::Result).to receive(:new).with('SE1 7QD', 'Southwark 034A').and_return(result)

        expect(subject).to be_ok
        expect(subject.invalid?).to be_falsy
        expect(subject.not_found?).to be_falsy
        expect(subject.error_message).to be_nil
        expect(subject.result).to be(result)
      end
    end

    context 'postcode has no space' do
      let(:postcode) { 'SE17QA' }

      it 'should return information about the given postcode' do
        expect(Postcodes::Result).to receive(:new).with('SE1 7QA', 'Lambeth 036B').and_return(result)

        expect(subject).to be_ok
        expect(subject.invalid?).to be_falsy
        expect(subject.not_found?).to be_falsy
        expect(subject.error_message).to be_nil
        expect(subject.result).to be(result)
      end
    end
  end

  context 'postcode is not valid' do
    let(:postcode) { 'SE1' }

    it 'should return invalid postcode' do
      expect(subject.ok?).to be_falsy
      expect(subject.invalid?).to be_truthy
      expect(subject.not_found?).to be_falsy
      expect(subject.error_message).to eq('Invalid postcode')
      expect { subject.result }.to raise_error(RuntimeError, 'Invalid postcode')
    end
  end

  context 'postcode is not found' do
    context 'postcode has correct spacing' do
      let(:postcode) { 'SH24 1AA' }

      it 'should return postcode not found' do
        expect(subject.ok?).to be_falsy
        expect(subject.invalid?).to be_falsy
        expect(subject.not_found?).to be_truthy
        expect(subject.error_message).to eq('Postcode not found')
        expect { subject.result }.to raise_error(RuntimeError, 'Postcode not found')
      end
    end

    context 'postcode has no space' do
      let(:postcode) { 'SH241AA' }

      it 'should return postcode not found' do
        expect(subject.ok?).to be_falsy
        expect(subject.invalid?).to be_falsy
        expect(subject.not_found?).to be_truthy
        expect(subject.error_message).to eq('Postcode not found')
        expect { subject.result }.to raise_error(RuntimeError, 'Postcode not found')
      end
    end
  end
end
