import { useContext, type Context } from 'react';

function useSafeContext<T>(context: Context<T>) {
  const _context = useContext(context);

  if (!_context) {
    throw new Error('Context는 반드시 Provider로 감싸져야 합니다.');
  }

  return _context;
}

export default useSafeContext;
