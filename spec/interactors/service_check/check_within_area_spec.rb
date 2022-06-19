# frozen_string_literal: true

require 'rails_helper'

describe ServiceCheck::CheckWithinArea do
  describe '.call' do
    context 'postcode was found' do
      subject(:context) { described_class.call(postcode: 'SE1 7QD', lsoa: 'Southwark 034A') }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'lsoa is allowed' do
        expect(context.service_available).to be_truthy
      end
    end

    context 'postcode was not found' do
      context 'postcode has correct spacing' do
        context 'but is still allowed' do
          subject(:context) { described_class.call(postcode: 'SH24 1AA', not_found: true) }

          it 'succeeds' do
            expect(context).to be_a_success
          end

          it 'lsoa is allowed' do
            expect(context.service_available).to be_truthy
          end
        end

        context 'but is not allowed' do
          subject(:context) { described_class.call(postcode: 'MH24 1AA', not_found: true) }

          it 'succeeds' do
            expect(context).to be_a_success
          end

          it 'lsoa is not allowed' do
            expect(context.service_available).to be_falsy
          end
        end
      end

      context 'postcode has no space' do
        context 'but is still allowed' do
          subject(:context) { described_class.call(postcode: 'SH241AA', not_found: true) }

          it 'succeeds' do
            expect(context).to be_a_success
          end

          it 'lsoa is allowed' do
            expect(context.service_available).to be_truthy
          end
        end

        context 'but is not allowed' do
          subject(:context) { described_class.call(postcode: 'MH241AA', not_found: true) }

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
