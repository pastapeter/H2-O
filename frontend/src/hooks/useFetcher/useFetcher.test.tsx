import type { PropsWithChildren } from 'react';
import useFetcher from './useFetcher';
import { renderHook, waitFor } from '@/tests/test-util';
import { ErrorBoundary } from '@/components/common';
import { StyleProvider } from '@/providers';

const GET_API_URL = '/car/1/trim';

const mockFetchFn = async (url: string) => {
  const response = await fetch(`${import.meta.env.VITE_API_BASE_URL}${url}`, {
    method: 'GET',

    headers: {
      'Content-Type': 'application/json',
    },
  });

  return response.json();
};

const throws = async () => {
  throw new Error('Error');
};

function TestProviders({ children }: PropsWithChildren) {
  return (
    <StyleProvider>
      <ErrorBoundary>{children}</ErrorBoundary>
    </StyleProvider>
  );
}

// TODO: dependecy array에 대한 test를 추가하고싶은데 dependency 값을 변경해도 refetch가 실행되지 않음 어떻게 해야할지 고민해봐야겠다.
describe('useFetcher hook 테스트', () => {
  it('useFetcher는 fetchFn을 실행하고 결과를 반환한다.', () => {
    const { result } = renderHook(() => useFetcher({ fetchFn: () => mockFetchFn(GET_API_URL) }), {
      wrapper: ErrorBoundary,
    });

    expect(result.current).toBeTruthy();
  });

  it('useFetcher는 fetchFn을 실행하는 동안 isLoading 값을 true로 반환한다.', () => {
    const { result } = renderHook(() => useFetcher({ fetchFn: () => mockFetchFn(GET_API_URL) }), {
      wrapper: ErrorBoundary,
    });

    expect(result.current.isLoading).toBeTruthy();
  });

  it('useFetcher는 fetchFn을 실행 완료하면 isLoading을 false로 반환한다.', async () => {
    const { result } = renderHook(() => useFetcher({ fetchFn: () => mockFetchFn(GET_API_URL) }), {
      wrapper: ErrorBoundary,
    });

    expect(result.current.isLoading).toBeTruthy();
    await waitFor(() => expect(result.current.isLoading).toBeFalsy());
  });

  it('useFetcher는 fetchFn을 성공적으로 실행 완료하면 data를 반환한다.', async () => {
    const { result } = renderHook(() => useFetcher({ fetchFn: () => mockFetchFn(GET_API_URL) }), {
      wrapper: ErrorBoundary,
    });

    await waitFor(() => expect(result.current.data).toBeDefined());
  });

  it('useFetcher는 fetchFn을 성공적으로 실행 완료하면 data를 반환한다.', async () => {
    const { result } = renderHook(() => useFetcher({ fetchFn: () => mockFetchFn(GET_API_URL) }), {
      wrapper: ErrorBoundary,
    });

    await waitFor(() => expect(result.current.data).toBeDefined());
  });

  it('useFetcher는 onSuccess를 전달받아서 fetch가 성공했을때 실행할 수 있다.', async () => {
    const handleSuccess = vi.fn();
    const { result } = renderHook(
      () => useFetcher({ fetchFn: () => mockFetchFn(GET_API_URL), onSuccess: handleSuccess }),
      {
        wrapper: ErrorBoundary,
      },
    );

    expect(handleSuccess).not.toHaveBeenCalled();
    await waitFor(() => expect(result.current.data).toBeDefined());
    expect(handleSuccess).toHaveBeenCalledTimes(1);
  });

  it('useFetcher는 onError를 전달받아서 fetch가 성공했을때 실행할 수 있다.', async () => {
    const handleError = vi.fn();
    const { result } = renderHook(() => useFetcher({ fetchFn: () => throws(), onError: handleError }), {
      wrapper: TestProviders,
    });

    expect(handleError).not.toHaveBeenCalled();
    await waitFor(() => expect(result.current.data).toBeDefined());
    expect(handleError).toHaveBeenCalledTimes(1);
  });

  it('useFetcher는 enabled가 true일 때만 fetch를 실행한다.', async () => {
    const { result, rerender } = renderHook(() => useFetcher({ fetchFn: () => mockFetchFn(GET_API_URL) }), {
      initialProps: { enabled: false },
      wrapper: ErrorBoundary,
    });

    expect(result.current.data).toBeNull();
    rerender({ enabled: true });
    await waitFor(() => expect(result.current.data).not.toBeNull());
  });

  it('useFetcher는 deferTime을 전달받아서 deferTime 이후에 fetch를 실행한다.', async () => {
    const { result } = renderHook(() => useFetcher({ fetchFn: () => mockFetchFn(GET_API_URL), deferTime: 1000 }), {
      wrapper: ErrorBoundary,
    });

    await waitFor(() => expect(result.current.isLoading).toBeFalsy(), {
      timeout: 1100,
    });
  });
});
