# frozen_string_literal: true

module Api
  module V1
    class ServiceCheckController < ApplicationController
      def lookup
        result = ServiceCheck::Lookup.call(postcode: params[:postcode])

        if result.success?
          render json: { service_available: result.service_available }, status: :ok
        else
          render json: { error: result.message }, status: :ok
        end
      end
    end
  end
end
