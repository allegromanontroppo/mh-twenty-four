# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ServiceCheck', type: :request, vcr: true do
  describe 'GET /api/v1/service_check/lookup' do
    let(:headers) { { 'ACCEPT' => 'application/json' } }

    context 'successful postcode lookup' do
      it 'returns service_available' do
        get('/api/v1/service_check/lookup/SE1%207QD', headers:)

        expect(response.body).to eq('{"service_available":true}')
        expect(response.status).to eq(200)
      end
    end

    context 'postcode not found' do
      it 'returns service_available' do
        get('/api/v1/service_check/lookup/SH24%201AA', headers:)

        expect(response.body).to eq('{"service_available":true}')
        expect(response.status).to eq(200)
      end
    end

    context 'unsuccessful postcode lookup' do
      it 'returns error message' do
        get('/api/v1/service_check/lookup/SE1', headers:)

        expect(response.body).to eq('{"error":"Invalid postcode"}')
        expect(response.status).to eq(200)
      end
    end
  end
end
