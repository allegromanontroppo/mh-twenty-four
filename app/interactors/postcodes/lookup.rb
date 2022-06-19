# frozen_string_literal: true

# PostcodeLookup interactor

module Postcodes
  class Lookup
    include Interactor::Organizer

    organize FindLsoa, CheckWithinArea
  end
end
