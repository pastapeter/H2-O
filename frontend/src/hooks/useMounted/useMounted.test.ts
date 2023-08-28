import useMounted from './useMounted';
import { renderHook } from '@/tests/test-util';

// renderHook이 useEffect가 호출되기 전의 값인 false를 반환하지 않아서
// 찾아보았더니 result가 가장 최신의 값을 반환한다고 한다.
// https://testing-library.com/docs/react-testing-library/api#result
describe('useMounted hook 테스트', () => {
  it('useMounted는 렌더링 된 후 true를 반환한다.', () => {
    const { result } = renderHook(() => useMounted());

    expect(result.current).toBeTruthy();
  });
});
