import { type PropsWithChildren, createContext } from 'react';
import useSafeContext from './useSafeContext';
import { renderHook } from '@/tests/test-util';

const TestContext = createContext<string | null>(null);

function TestProvider({ children }: PropsWithChildren) {
  const value = 'test';
  return <TestContext.Provider value={value}>{children}</TestContext.Provider>;
}

describe('useSafeContext hook 테스트', () => {
  it('Provider로 감싸지 않은 경우 에러를 던진다.', () => {
    expect(() => {
      renderHook(() => useSafeContext(TestContext));
    }).toThrowError(/Context는 반드시 Provider로 감싸져야 합니다./);
  });

  it('Provider 감싼 경우 context값을 정상적으로 전달받는다.', () => {
    const { result } = renderHook(() => useSafeContext(TestContext), {
      wrapper: TestProvider,
    });

    expect(result.current).toBe('test');
  });
});
