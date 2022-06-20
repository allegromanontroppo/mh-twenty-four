import ServiceChecker from './components/service-checker';

function App() {
    return (
        <div>
            <header className="bg-cyan-50 px-2 py-4 mb-5 border-cyan-900">
                <div className=" max-w-3xl mx-auto">
                    <p className="text-4xl font-extrabold">
                        <span className="text-cyan-900">MH</span>
                        <span className="text-cyan-500">:</span>
                        <span className="text-cyan-900">24</span>
                    </p>
                </div>
            </header>

            <main className="bg-zinc-50 px-2 py-4">
                <div className="max-w-3xl mx-auto">
                    <ServiceChecker />
                </div>
            </main>
        </div>
    );
}

export default App;
