import { useEffect, useState } from 'react';

interface Props<TData> {
  fetchFn: () => Promise<TData>;
}

/**
 *
 * @example
 * fetcher로 api request 함수를 넘겨주면 해당 함수를 실행하고 결과(로딩, 데이터, 에러)를 반환한다.
 * ```tsx
 * const { isLoading, data, error} = useFetcher({fetchFn: () => fetch('request url')});
 * ```
 */
function useFetcher<TData = unknown>({ fetchFn }: Props<TData>) {
  const [isLoading, setIsLoading] = useState(false);
  const [data, setData] = useState<TData | null>(null);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    (async function () {
      try {
        setIsLoading(true);
        const response = await fetchFn();
        setData(response);
      } catch (err) {
        if (err instanceof Error) {
          setError(err);
        }
      } finally {
        setIsLoading(false);
      }
    })();
  }, [fetchFn]);

  return { isLoading, data, error } as const;
}

export default useFetcher;
