# frozen_string_literal: true

# PostcodeLookup interactor

module ServiceCheck
  class Lookup
    include Interactor::Organizer

    organize FindLsoa, CheckWithinArea
  end
end
