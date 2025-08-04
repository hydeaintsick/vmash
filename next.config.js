/** @type {import('next').NextConfig} */
const nextConfig = {
  experimental: {
    appDir: true,
  },
  async rewrites() {
    return [
      {
        source: "/guacamole/:path*",
        destination: "http://localhost:8080/guacamole/:path*",
      },
    ];
  },
};

module.exports = nextConfig;
