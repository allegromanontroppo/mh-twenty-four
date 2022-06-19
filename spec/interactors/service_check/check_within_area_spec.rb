# frozen_string_literal: true

require 'rails_helper'

describe ServiceCheck::CheckWithinArea do
  describe '.call' do
    context 'postcode was found' do
      context 'and is inside the area' do
        subject(:context) { described_class.call(postcode: 'SE1 7QD', lsoa: 'Southwark 034A') }

        it 'succeeds' do
          expect(context).to be_a_success
        end

        it 'lsoa is allowed' do
          expect(context.service_available).to be_truthy
        end
      end

      context 'but is not inside the area' do
        subject(:context) do
          described_class.call(postcode: 'G3 8YW', lsoa: 'Finnieston and Kelvinhaugh - 02')
        end

        it 'succeeds' do
          expect(context).to be_a_success
        end

        it 'lsoa is allowed' do
          expect(context.service_available).to be(false)
        end
      end
    end

    context 'postcode was not found' do
      context 'postcode has correct spacing' do
        context 'but is still inside the area' do
          subject(:context) { described_class.call(postcode: 'SH24 1AA', not_found: true) }

          it 'succeeds' do
            expect(context).to be_a_success
          end

          it 'lsoa is allowed' do
            expect(context.service_available).to be_truthy
          end
        end

        context 'but is not inside the area' do
          subject(:context) { described_class.call(postcode: 'MH24 1AA', not_found: true) }

          it 'succeeds' do
            expect(context).to be_a_success
          end

          it 'lsoa is not allowed' do
            expect(context.service_available).to be_falsy
          end
        end
      end
    end
  end
end
