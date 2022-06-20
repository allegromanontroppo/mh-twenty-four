import React, { useCallback, useId, useState } from 'react';

import CheatSheet from './cheat-sheet';

export default function ServiceChecker() {
    const passwordFieldId = useId();

    const [postcode, setPostcode] = useState('');
    const [lookupResult, setLookupResult] = useState({});

    const handleSubmit = useCallback(
        async (e) => {
            e.preventDefault();
            setLookupResult({});

            const response = await fetch(`/api/v1/service_check/lookup/${postcode}`);
            if (response.ok) {
                const { service_available: serviceAvailable, error } = await response.json();
                setLookupResult({ serviceAvailable, error });
            }
        },
        [postcode]
    );

    return (
        <div className="space-y-4 md:flex md:justify-between md:space-x-4 md:space-y-0">
            <div className="space-y-2">
                <p className="font-medium uppercase">Check what services are available to you</p>
                <form className="flex space-x-2" onSubmit={handleSubmit}>
                    <div>
                        <label htmlFor={passwordFieldId} className="sr-only">
                            Postcode
                        </label>
                        <input
                            id={passwordFieldId}
                            className="appearance-none text-grey-darker border  py-2 px-4"
                            placeholder="Postcode"
                            value={postcode}
                            onChange={(e) => setPostcode(e.target.value.toUpperCase())}
                        />
                    </div>
                    <button type="submit" className="bg-cyan-500 text-white py-2 px-8" disabled={!postcode}>
                        Check eligibility
                    </button>
                </form>
                {lookupResult.serviceAvailable === true && (
                    <p className="uppercase">Good news! our services are available in your area</p>
                )}
                {lookupResult.serviceAvailable === false && (
                    <p className="uppercase">Sorry, our services are not available in your area</p>
                )}
                {lookupResult.error && <p className="text-red-600">{lookupResult.error}</p>}
            </div>
            <CheatSheet setPostcode={setPostcode} />
        </div>
    );
}
