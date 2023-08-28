import { createSerializer, matchers as emotionMatchers } from '@emotion/jest';
import '@testing-library/jest-dom';
import matchers from '@testing-library/jest-dom/matchers';
import { cleanup } from '@testing-library/react';
import { CacheStorageMock } from './CacheStorageMock';
import { server } from '@/mocks/server';
import { expect } from 'vitest';
import 'vitest-canvas-mock';
import 'vitest-localstorage-mock';

vi.stubGlobal('caches', new CacheStorageMock());

expect.extend(matchers);
// 이상한 타입오류가 나서 any로 일단 무시
expect.extend(emotionMatchers as any);
expect.addSnapshotSerializer(createSerializer());

beforeAll(() => server.listen({ onUnhandledRequest: 'error' }));

afterEach(() => {
  cleanup();
  server.resetHandlers();
});

afterAll(() => server.close());
