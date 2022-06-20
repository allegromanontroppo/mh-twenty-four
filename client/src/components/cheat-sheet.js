import React from 'react';

const predefinedLocations = [
    ['Southwark', 'SE1 7QD'],
    ['Lambeth', 'SE1 7QA'],
    ['Glasgow', 'G3 8YW'],
    ['Liverpool', 'L18 9TN'],
    ['Brigadoon', 'BG7 00N'],
    ['Also available', 'SH24 1AA'],
    ['Also available', 'SH24 1AB'],
];

export default function CheatSheet({ setPostcode }) {
    return (
        <div>
            <p className="font-medium uppercase">Cheat sheet</p>
            <ul>
                {predefinedLocations.map(([city, postCode]) => (
                    <li key={postCode}>
                        <button className="hover:underline" onClick={() => setPostcode(postCode)}>
                            {city}: {postCode}
                        </button>
                    </li>
                ))}
            </ul>
        </div>
    );
}
