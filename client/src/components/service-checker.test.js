import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import fetchMock from 'fetch-mock';

import ServiceChecker from './service-checker';

describe('ServiceChecker', () => {
    describe('finds service available', () => {
        test('Submits SE1 7QD', async () => {
            fetchMock.get('/api/v1/service_check/lookup/SE1 7QD', { service_available: true });

            render(<ServiceChecker />);

            expect(screen.getByText('Check what services are available to you')).toBeInTheDocument();

            const input = screen.getByLabelText('Postcode');
            await userEvent.type(input, 'SE1 7QD{enter}');

            expect(await screen.findByText('Good news! our services are available in your area')).toBeInTheDocument();
        });
    });

    describe('finds service unavailable', () => {
        test('Submits L18 9TN', async () => {
            fetchMock.get('/api/v1/service_check/lookup/L18 9TN', { service_available: false });

            render(<ServiceChecker />);

            expect(screen.getByText('Check what services are available to you')).toBeInTheDocument();

            const input = screen.getByLabelText('Postcode');
            await userEvent.type(input, 'L18 9TN{enter}');

            expect(await screen.findByText('Sorry, our services are not available in your area')).toBeInTheDocument();
        });
    });

    describe('incorrect password', () => {
        test('Submits BG7 00N', async () => {
            fetchMock.get('/api/v1/service_check/lookup/BG7 00N', { error: 'Invalid postcode' });

            render(<ServiceChecker />);

            expect(screen.getByText('Check what services are available to you')).toBeInTheDocument();

            const input = screen.getByLabelText('Postcode');
            await userEvent.type(input, 'BG7 00N{enter}');

            expect(await screen.findByText('Invalid postcode')).toBeInTheDocument();
        });
    });
});
