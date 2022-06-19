# frozen_string_literal: true

# CheckWithinArea interactor

ALLOWED_LSOAS = %w[Southwark Lambeth].freeze
OTHER_PERMITTED_POSTCODES = %w[SH241AA SH241AB].freeze

module ServiceCheck
  class CheckWithinArea
    include Interactor

    def call
      context.service_available = true if allowed_lsoa?
      context.service_available = true if context.not_found && other_permitted_postcode?
    end

    private

    def allowed_lsoa?
      # this would be a database query in reality I expect
      context.lsoa.present? && ALLOWED_LSOAS.any? { |allowed_lsoa| context.lsoa.start_with?(allowed_lsoa) }
    end

    def other_permitted_postcode?
      # this would also be a database query in reality I expect
      context.postcode.present? && OTHER_PERMITTED_POSTCODES.include?(context.postcode.gsub(/\s/, ''))
    end
  end
end
