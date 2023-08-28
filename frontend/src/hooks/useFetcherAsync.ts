interface Props<TData> {
  fetchFn: () => Promise<TData>;
  dependency?: unknown[];
  enabled?: boolean;
  deferTime?: number;
  onSuccess?: (data: TData) => void;
  onError?: (error: Error) => void;
}

type Status = 'pending' | 'resolved' | 'rejected';

// TODO: 더 좋은 방법을 생각해보아야 함.. any 타입을 사용하면 안되는데..
// 외부에 선언해야 해서 제네릭을 사용할 수 없음
let status: Status = 'pending';
let data: any;
let error: Error;
let promise: Promise<any>;

function useFetcherAsync<TData = unknown>({ fetchFn, deferTime = 0, onSuccess, onError }: Props<TData>) {
  if (data) {
    return data as TData;
  }

  if (promise) {
    throw promise;
  }

  promise = fetchFn();
  promise
    .then((response) => {
      setTimeout(() => {
        status = 'resolved';
        data = response;
        if (onSuccess) onSuccess(response);
      }, deferTime);
    })
    .catch((err) => {
      status = 'rejected';
      error = err;
      if (onError) onError(err);
    });

  if (status === 'pending') {
    throw promise;
  }

  if (status === 'rejected') {
    throw error;
  }
}

export default useFetcherAsync;
