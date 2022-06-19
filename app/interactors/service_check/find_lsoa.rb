# frozen_string_literal: true

# FindLsoa interactor

module ServiceCheck
  class FindLsoa
    include Interactor

    def call
      if postcode_lookup.ok?
        context.postcode = postcode_lookup.result.postcode
        context.lsoa = postcode_lookup.result.lsoa
        return
      end

      if postcode_lookup.not_found?
        context.not_found = true
        return
      end

      context.fail!(message: postcode_lookup.error_message)
    end

    private

    def postcode_lookup
      @postcode_lookup ||= Postcodes::Factory.create(postcode: context.postcode)
    end
  end
end
