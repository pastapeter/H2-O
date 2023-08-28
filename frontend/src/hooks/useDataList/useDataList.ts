import { useCallback, useState } from 'react';

interface Props<T> {
  initDataList?: T[];
}

function useDataList<T>({ initDataList }: Props<T>) {
  const [dataList, setDataList] = useState(initDataList ? initDataList : []);

  const compareData = <T>(data1: T, data2: T): boolean => {
    if (data1 instanceof Object && data2 instanceof Object) {
      const keys = Object.keys(data1);
      return keys.reduce(
        (acc, key) => acc && data1[key as keyof typeof data1] === data2[key as keyof typeof data2],
        true,
      );
    } else {
      return data1 === data2;
    }
  };

  const addData = useCallback((data: T) => {
    setDataList((prevList) => [...prevList, data]);
  }, []);

  const removeData = useCallback((data: T) => {
    setDataList((prevList) => prevList.filter((item) => !compareData(item, data)));
  }, []);

  const hasData = useCallback(
    (data: T) => {
      return dataList.some((item) => compareData(item, data));
    },
    [dataList],
  );

  const isEmptyList = useCallback(() => {
    return dataList.length === 0;
  }, [dataList]);

  return { dataList, addData, removeData, hasData, isEmptyList } as const;
}
export default useDataList;
