import '@testing-library/jest-dom';
import matchers from '@testing-library/jest-dom/matchers';
import { cleanup } from '@testing-library/react';
import { CacheStorageMock } from './CacheStorageMock';
import { server } from '@/mocks/server';
import { expect } from 'vitest';
import 'vitest-canvas-mock';

vi.stubGlobal('caches', new CacheStorageMock());

expect.extend(matchers);

beforeAll(() => server.listen({ onUnhandledRequest: 'error' }));

afterEach(() => {
  cleanup();
  server.resetHandlers();
});

afterAll(() => server.close());
