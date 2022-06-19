# frozen_string_literal: true

require 'rails_helper'

describe Postcodes::Factory do
  describe '.create' do
    it 'should return a PostcodesIo object' do
      # Arrange
      postcodes_io = double(:postcodes_io)

      expect(Postcodes::PostcodesIo).to receive(:new).with(post_code: 'SW1A 2AA').and_return(postcodes_io)

      # Act
      # Assert
      expect(described_class.create(post_code: 'SW1A 2AA')).to be(postcodes_io)
    end
  end
end
