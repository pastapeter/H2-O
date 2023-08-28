import { useCallback, useMemo, useState } from 'react';

interface Props<T> {
  data: T[];
  initialPage?: number;
  pageSize?: number;
}

function usePaigination<T>({ data, initialPage = 0, pageSize = 4 }: Props<T>) {
  const [currentPage, setCurrentPage] = useState(initialPage);

  const totalPage = Math.ceil(data.length / pageSize);
  const hasPagination = totalPage > 1;
  const isStartPage = currentPage === 0;
  const isEndPage = currentPage === totalPage - 1;
  const startIdx = pageSize * currentPage;

  const currentSlice = useMemo(
    () => data.slice(currentPage * pageSize, (currentPage + 1) * pageSize),
    [data, currentPage, pageSize],
  );

  const nextPage = useCallback(() => {
    setCurrentPage((prev) => {
      if (prev === totalPage - 1) return prev;
      return prev + 1;
    });
  }, [totalPage]);

  const prevPage = useCallback(() => {
    setCurrentPage((prev) => {
      if (prev === 0) return prev;
      return prev - 1;
    });
  }, []);

  return {
    currentSlice,
    hasPagination,
    isStartPage,
    isEndPage,
    startIdx,
    totalPage,
    currentPage,
    nextPage,
    prevPage,
  } as const;
}

export default usePaigination;
