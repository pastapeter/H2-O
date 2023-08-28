import { calculateImgIdx } from '../../utils/calculateImgIdx';
import useRotate from './useRotate';
import { fireEvent, render, renderHook } from '@/tests/test-util';

describe('useRotate 테스트', () => {
  it('useRotate를 불러오면 초기화되어야 한다.', () => {
    const { result } = renderHook(() => useRotate());
    const { nowImgIdx, nextImgIdx, mouseX, isMouseDown } = result.current.state;

    expect(nowImgIdx).toBe(0);
    expect(nextImgIdx).toBe(0);
    expect(mouseX).toBe(0);
    expect(isMouseDown).toBe(false);
  });

  it('handleMouseDown을 호출하면 state의 mouseX가 mouseEvent의 clientX로 바뀐다.', () => {
    const { result } = renderHook(() => useRotate());
    const { handleMouseDown } = result.current;

    render(<div id='test-div' onMouseDown={handleMouseDown} />);
    const domElement = document.getElementById('test-div');
    if (!domElement) throw new Error('dom Element가 존재하지 않습니다.');

    const mouse = { clientX: 100 };
    fireEvent.mouseDown(domElement, mouse);

    expect(result.current.state.mouseX).toBe(mouse.clientX);
    expect(result.current.state.isMouseDown).toBe(true);
  });

  it('handleMouseMove를 호출하면 state의 mouseX와 현재 mouseEvent의 clientX사이 차이값을 통해서 이미지 index을 state의 nextImgIdx에 저장한다.', () => {
    const { result } = renderHook(() => useRotate());
    const { handleMouseDown, handleMouseMove } = result.current;

    render(<div id='test-div' onMouseDown={handleMouseDown} onMouseMove={handleMouseMove} />);
    const domElement = document.getElementById('test-div');
    if (!domElement) throw new Error('dom Element가 존재하지 않습니다.');

    const mouse1 = { clientX: 100 };
    const mouse2 = { clientX: 200 };
    fireEvent.mouseDown(domElement, mouse1);
    fireEvent.mouseMove(domElement, mouse2);

    expect(result.current.state.nextImgIdx).toBe(calculateImgIdx(mouse1.clientX, mouse2.clientX, 0));
  });

  it('handleMouseUp를 호출하면 state의 nowImgIdx는 state의 nextImgIdx, isMouseDown은 false, mouseX는 0이 되어야한다.', () => {
    const { result } = renderHook(() => useRotate());
    const { handleMouseUp, handleMouseDown, handleMouseMove } = result.current;

    render(<div id='test-div' onMouseDown={handleMouseDown} onMouseMove={handleMouseMove} onMouseUp={handleMouseUp} />);
    const domElement = document.getElementById('test-div');
    if (!domElement) throw new Error('dom Element가 존재하지 않습니다.');

    const mouse1 = { clientX: 100 };
    const mouse2 = { clientX: 200 };
    fireEvent.mouseDown(domElement, mouse1);
    fireEvent.mouseMove(domElement, mouse2);
    fireEvent.mouseUp(domElement);

    expect(result.current.state.nowImgIdx).toBe(result.current.state.nextImgIdx);
    expect(result.current.state.isMouseDown).toBe(false);
    expect(result.current.state.mouseX).toBe(0);
  });
});
