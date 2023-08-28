import { useEffect, useReducer } from 'react';
import { useErrorBoundary } from 'react-error-boundary';

interface Props<TData> {
  fetchFn: () => Promise<TData>;
  dependency?: unknown[];
  enabled?: boolean;
  deferTime?: number;
  onSuccess?: (data: TData) => void;
  onError?: (error: Error) => void;
}

interface State<TData> {
  isLoading: boolean;
  data: TData | null;
  error: Error | null;
}

type Action<TData> =
  | {
      type: 'LOADING';
    }
  | {
      type: 'SUCCESS';
      payload: TData;
    }
  | {
      type: 'ERROR';
      payload: Error;
    };

/**
 *
 * @example
 * fetcher로 api request 함수를 넘겨주면 해당 함수를 실행하고 결과(로딩, 데이터, 에러)를 반환한다.
 * ```tsx
 * const { isLoading, data, error} = useFetcher({fetchFn: () => fetch('request url')});
 * ```
 */
function useFetcher<TData = unknown>({
  fetchFn,
  dependency = [],
  enabled = true,
  deferTime = 0,
  onSuccess,
  onError,
}: Props<TData>) {
  const { showBoundary } = useErrorBoundary();
  const initialState: State<TData> = {
    isLoading: false,
    data: null,
    error: null,
  };

  const reducer = (state: State<TData>, action: Action<TData>): State<TData> => {
    switch (action.type) {
      case 'LOADING':
        return { ...state, isLoading: true };
      case 'SUCCESS':
        return { ...state, isLoading: false, data: action.payload };
      case 'ERROR':
        return { ...state, isLoading: false, error: action.payload };
      default:
        return state;
    }
  };

  const [state, dispatch] = useReducer(reducer, initialState);

  const _fetch = async () => {
    try {
      dispatch({ type: 'LOADING' });
      const response = await fetchFn();
      if (deferTime > 0) await sleep(deferTime);
      dispatch({ type: 'SUCCESS', payload: response });
      if (onSuccess) onSuccess(response);
    } catch (err) {
      if (err instanceof Error) {
        dispatch({ type: 'ERROR', payload: err });
        if (onError) onError(err);
        showBoundary(err);
      }
    }
  };

  useEffect(() => {
    if (!enabled) return;

    _fetch();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [enabled, ...dependency]);

  return { ...state, refetch: _fetch } as const;
}

const sleep = (time: number) => {
  return new Promise((resolve) => setTimeout(resolve, time));
};

export default useFetcher;
