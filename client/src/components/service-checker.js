import React, { useCallback, useState } from 'react';

export default function ServiceChecker() {
    const [postcode, setPostcode] = useState('');
    const [lookupResult, setLookupResult] = useState({});

    const handleSubmit = useCallback(
        async (e) => {
            e.preventDefault();

            if (!postcode) {
                return;
            }

            const response = await fetch(`/api/v1/service_check/lookup/${postcode}`);
            if (response.ok) {
                const { service_available: serviceAvailable, error } = await response.json();
                setLookupResult({ serviceAvailable, error });
            }
        },
        [postcode]
    );

    console.log(lookupResult);

    return (
        <div className="space-y-2">
            <p className="font-medium">CHECK WHAT SERVICES ARE AVAILABLE TO YOU</p>
            <form className="flex space-x-2" onSubmit={handleSubmit}>
                <input
                    className="appearance-none text-grey-darker border  py-2 px-4"
                    placeholder="Postcode"
                    value={postcode}
                    onChange={(e) => setPostcode(e.target.value.toUpperCase())}
                />
                <button type="submit" className="bg-cyan-500 text-white py-2 px-8">
                    Check eligibility
                </button>
            </form>
            {lookupResult.serviceAvailable === true && <p>GOOD NEWS! OUR SERVICES ARE AVAILABLE IN YOUR AREA</p>}
            {lookupResult.serviceAvailable === false && <p>SORRY, OUR SERVICES ARE NOT AVAILABLE IN YOUR AREA</p>}
            {lookupResult.error && <p className="text-red-600">{lookupResult.error}</p>}
        </div>
    );
}
