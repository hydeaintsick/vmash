import { NextResponse } from "next/server";

export async function GET() {
  try {
    // Check if demo desktop is running (VNC on port 5900)
    const demoResponse = await fetch("http://localhost:5900", {
      method: "GET",
      timeout: 5000,
    }).catch(() => null);

    const isDemoRunning = demoResponse !== null;

    return NextResponse.json({
      connected: isDemoRunning,
      demo: isDemoRunning,
      timestamp: new Date().toISOString(),
    });
  } catch (error) {
    return NextResponse.json({
      connected: false,
      guacamole: false,
      demo: false,
      error: "Failed to check connection status",
      timestamp: new Date().toISOString(),
    });
  }
}
