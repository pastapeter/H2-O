import useToggle from './useToggle';
import { act, renderHook } from '@/tests/test-util';

describe('useToggle 테스트', () => {
  it('initialState를 전달하면 status가 initialState와 같아야 한다.', () => {
    const { result } = renderHook(() => useToggle(false));

    expect(result.current.status).toBe(false);
  });

  it('setOn을 호출하면 status가 true가 된다.', () => {
    const { result } = renderHook(() => useToggle(false));
    const { setOn } = result.current;

    expect(result.current.status).toBe(false);
    act(() => setOn());
    expect(result.current.status).toBe(true);
  });

  it('setOff을 호출하면 status가 false가 된다.', () => {
    const { result } = renderHook(() => useToggle(true));
    const { setOff } = result.current;

    expect(result.current.status).toBe(true);
    act(() => setOff());
    expect(result.current.status).toBe(false);
  });

  it('toggle을 호출하면 status 값이 전환 된다.', () => {
    const { result } = renderHook(() => useToggle(true));
    const { toggle } = result.current;

    expect(result.current.status).toBe(true);
    act(() => toggle());
    expect(result.current.status).toBe(false);
  });
});
