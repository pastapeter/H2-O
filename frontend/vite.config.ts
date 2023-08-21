import react from '@vitejs/plugin-react';
import { defineConfig, loadEnv } from 'vite';
import svgr from 'vite-plugin-svgr';
import tsconfigPaths from 'vite-tsconfig-paths';

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => {
  Object.assign(process.env, loadEnv(mode, process.cwd(), ''));

  return defineConfig({
    plugins: [
      react({ jsxImportSource: '@emotion/react', babel: { plugins: ['@emotion/babel-plugin'] } }),
      svgr(),
      tsconfigPaths(),
    ],
    server: {
      proxy: {
        '/api': {
          target: process.env.VITE_API_BASE_URL,
          changeOrigin: true,
          rewrite: (path) => path.replace(/^\/api/, ''),
        },
      },
    },
  });
});
