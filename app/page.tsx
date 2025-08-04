"use client";

import { useState, useEffect } from "react";

export default function Home() {
  const [isConnected, setIsConnected] = useState(false);
  const [isLoading, setIsLoading] = useState(true);
  const [showDesktop, setShowDesktop] = useState(false);

  useEffect(() => {
    const checkConnection = () => {
      fetch("/api/status")
        .then((response) => response.json())
        .then((data) => {
          setIsConnected(data.connected);
          setIsLoading(false);
        })
        .catch(() => {
          setIsConnected(false);
          setIsLoading(false);
        });
    };

    checkConnection();
    const interval = setInterval(checkConnection, 5000);
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="h-screen bg-gray-900 flex flex-col">
      <header className="bg-gray-800 border-b border-gray-700 p-4 flex-shrink-0">
        <div className="max-w-7xl mx-auto flex justify-between items-center">
          <h1 className="text-xl font-bold text-white">
            WinWeb - Linux Desktop
          </h1>
          <div className="flex items-center space-x-4">
            <div
              className={`px-2 py-1 rounded-full text-xs font-medium ${
                isLoading
                  ? "bg-yellow-100 text-yellow-800"
                  : isConnected
                  ? "bg-green-100 text-green-800"
                  : "bg-red-100 text-red-800"
              }`}
            >
              {isLoading ? "Connecting..." : isConnected ? "Online" : "Offline"}
            </div>
          </div>
        </div>
      </header>

      <main className="flex-1 flex flex-col min-h-0">
        {isLoading ? (
          <div className="flex items-center justify-center flex-1">
            <div className="text-center">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-400 mx-auto mb-4"></div>
              <p className="text-gray-400">Connecting to Linux desktop...</p>
            </div>
          </div>
        ) : isConnected ? (
          showDesktop ? (
            <div className="flex-1 bg-black flex min-h-0">
              <iframe
                src="http://localhost:5900/?autoconnect=true&resize=scale&toolbar=hidden"
                className="w-full h-full border-none"
                title="Linux Desktop"
                allow="fullscreen"
                sandbox="allow-same-origin allow-scripts allow-forms allow-popups allow-popups-to-escape-sandbox"
              />
            </div>
          ) : (
            <div className="flex items-center justify-center flex-1">
              <div className="text-center">
                <h2 className="text-2xl font-bold text-white mb-4">
                  Linux Desktop Ready
                </h2>
                <p className="text-gray-400 mb-6">
                  Your Linux desktop is online and ready to use.
                </p>
                <button
                  onClick={() => setShowDesktop(true)}
                  className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-lg font-medium transition-colors"
                >
                  Lancer le Bureau Linux
                </button>
              </div>
            </div>
          )
        ) : (
          <div className="flex items-center justify-center flex-1">
            <div className="text-center">
              <h2 className="text-2xl font-bold text-white mb-2">
                Connection Failed
              </h2>
              <p className="text-gray-400 mb-4">
                Unable to connect to the Linux desktop. Please check if the
                Docker containers are running.
              </p>
              <button
                onClick={() => window.location.reload()}
                className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md"
              >
                Retry Connection
              </button>
            </div>
          </div>
        )}
      </main>

      <footer className="bg-gray-800 border-t border-gray-700 p-4 flex-shrink-0">
        <div className="max-w-7xl mx-auto text-center">
          <p className="text-gray-400 text-sm">
            Made with ❤️ by{" "}
            <a
              href="https://github.com/bnktop"
              target="_blank"
              rel="noopener noreferrer"
              className="text-blue-400 hover:text-blue-300 transition-colors"
            >
              bnktop
            </a>
          </p>
        </div>
      </footer>
    </div>
  );
}
