# frozen_string_literal: true

# this abstracts the concrete class which interacts

# with the postcode api so that it's far easier

# to switch to alternative service later on

module Postcodes
  class Factory
    def self.create(**args)
      PostcodesIo.new(**args)
    end
  end
end
