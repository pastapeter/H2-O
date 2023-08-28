import { useCallback, useState } from 'react';

function useToggle(initialState: boolean) {
  const [status, setStatus] = useState(initialState);

  const toggle = useCallback(() => {
    setStatus((prev) => !prev);
  }, []);

  const setOn = useCallback(() => {
    setStatus(true);
  }, []);

  const setOff = useCallback(() => {
    setStatus(false);
  }, []);

  return { status, toggle, setOn, setOff } as const;
}

export default useToggle;
