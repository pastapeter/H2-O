import react from '@vitejs/plugin-react';
import { resolve } from 'node:path';
import svgr from 'vite-plugin-svgr';
import { defineConfig } from 'vitest/config';

export default defineConfig({
  plugins: [react(), svgr()],
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: './src/tests/setup.ts',
  },
  resolve: {
    alias: [{ find: '@', replacement: resolve(__dirname, './src') }],
  },
});
