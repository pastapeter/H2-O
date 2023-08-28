import { calculateImgIdx } from './calculateImgIdx';

describe('calculateImgIdx 유틸 함수 테스트', () => {
  const ROTATE_SENSITIVITY = 15;
  const IMG_CNT = 60;

  it('x좌표가 오른쪽으로 이동할 경우 테스트', () => {
    const prevX = 100;
    const currentX = 200;
    const nowImgIdx = 0;

    const diffXPos = prevX - currentX;
    const posToImgIdx = Math.ceil(diffXPos / ROTATE_SENSITIVITY);
    const nextImgIdx = (nowImgIdx + posToImgIdx + IMG_CNT) % IMG_CNT;

    const result = calculateImgIdx(prevX, currentX, nowImgIdx);

    expect(result).toBe(nextImgIdx);
  });

  it('x좌표가 왼쪽으로 이동할 경우 테스트', () => {
    const prevX = 200;
    const currentX = 100;
    const nowImgIdx = 0;

    const diffXPos = prevX - currentX;
    const posToImgIdx = Math.ceil(diffXPos / ROTATE_SENSITIVITY);
    const nextImgIdx = (nowImgIdx + posToImgIdx) % IMG_CNT;

    const result = calculateImgIdx(prevX, currentX, nowImgIdx);

    expect(result).toBe(nextImgIdx);
  });

  it('x좌표가 이동하지 않을 경우 테스트', () => {
    const prevX = 100;
    const currentX = 100;
    const nowImgIdx = 0;

    const diffXPos = prevX - currentX;
    const posToImgIdx = Math.ceil(diffXPos / ROTATE_SENSITIVITY);
    const nextImgIdx = (nowImgIdx + posToImgIdx) % IMG_CNT;

    const result = calculateImgIdx(prevX, currentX, nowImgIdx);
    expect(result).toBe(nextImgIdx);
  });
});
