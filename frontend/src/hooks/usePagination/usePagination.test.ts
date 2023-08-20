import usePagination from './usePagination';
import { act, renderHook } from '@/tests/test-util';

describe('usePagination 테스트', () => {
  const mockData = Array.from({ length: 10 }).map((_, idx) => idx);

  it('데이터와 페이지 사이지를 전달하면 총 페이지 수(totalPage)를 반환한다.', () => {
    const { result } = renderHook(() => usePagination({ data: mockData, pageSize: 4 }));

    expect(result.current.totalPage).toBe(3);
  });

  it('총 페이지 수가 1을 초과하지 않으면 hasPagination은 false를 반환한다.', () => {
    const { result } = renderHook(() => usePagination({ data: mockData, pageSize: 10 }));

    expect(result.current.hasPagination).toBe(false);
  });

  it('현재 페이지가 변경됨에 따라 페이지에 해당하는 데이터 리스트(currentSlice)가 반환된다.', () => {
    const { result } = renderHook(() => usePagination({ data: mockData, pageSize: 4 }));

    expect(result.current.currentSlice).toEqual([0, 1, 2, 3]);
    act(() => result.current.nextPage());
    expect(result.current.currentSlice).toEqual([4, 5, 6, 7]);
  });

  it('시작 페이지 여부에 따라 isStartPage가 boolean값으로 반환된다.', () => {
    const { result } = renderHook(() => usePagination({ data: mockData, initialPage: 0, pageSize: 4 }));

    expect(result.current.isStartPage).toBe(true);
    act(() => result.current.nextPage());
    expect(result.current.isStartPage).toBe(false);
  });

  it('마지막 페이지 여부에 따라 isEndPage가 boolean값으로 반환된다.', () => {
    const { result } = renderHook(() => usePagination({ data: mockData, initialPage: 2, pageSize: 4 }));

    expect(result.current.isEndPage).toBe(true);
    act(() => result.current.prevPage());
    expect(result.current.isEndPage).toBe(false);
  });

  it('nextPage를 호출하면 다음 페이지로 이동한다.', () => {
    const { result } = renderHook(() => usePagination({ data: mockData, pageSize: 4 }));

    expect(result.current.currentPage).toBe(0);
    act(() => result.current.nextPage());
    expect(result.current.currentPage).toBe(1);
  });

  it('prevPage를 호출하면 이전 페이지로 이동한다.', () => {
    const { result } = renderHook(() => usePagination({ data: mockData, initialPage: 1, pageSize: 4 }));

    expect(result.current.currentPage).toBe(1);
    act(() => result.current.prevPage());
    expect(result.current.currentPage).toBe(0);
  });

  it('마지막 페이지에서 nextPage를 호출하면 현재 페이지가 유지된다.', () => {
    const { result } = renderHook(() => usePagination({ data: mockData, initialPage: 2, pageSize: 4 }));

    act(() => result.current.nextPage());
    expect(result.current.currentPage).toBe(2);
  });

  it('첫 페이지에서 prevPage를 호출하면 현재 페이지가 유지된다.', () => {
    const { result } = renderHook(() => usePagination({ data: mockData, initialPage: 0, pageSize: 4 }));

    act(() => result.current.prevPage());
    expect(result.current.currentPage).toBe(0);
  });
});
