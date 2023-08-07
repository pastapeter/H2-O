import { MouseEventHandler, useState } from 'react';
import styled from '@emotion/styled';

// MOCK 데이터
const IMG_CNT = 60;
const SENSITIVITY = 10;
const numList = Array(IMG_CNT)
  .fill(1)
  .map((key, idx) => key + idx);
const MOCK_IMGS = numList.map((idx) => `/images/car3d/image_${idx.toString().padStart(3, '0')}.png`);

function CarImg() {
  const [nowIdx, setNowIdx] = useState(0);
  const [nextIdx, setNextIdx] = useState(0);
  const [isMouseDown, setIsMouseDown] = useState(0);

  const handleMouseDown: MouseEventHandler<HTMLDivElement> = (e) => {
    const x = e.clientX;
    setIsMouseDown(x);
  };

  const handleMouseMove: MouseEventHandler<HTMLDivElement> = (e) => {
    if (!isMouseDown) {
      e.preventDefault();
    } else {
      const dragged = Math.ceil((e.clientX - isMouseDown) / SENSITIVITY);
      if (nowIdx + dragged >= 0) {
        setNextIdx((nowIdx + dragged) % IMG_CNT);
      } else {
        setNextIdx(nowIdx + dragged + IMG_CNT);
      }
    }
  };

  const handleMouseUp: MouseEventHandler<HTMLDivElement> = () => {
    setIsMouseDown(0);
    setNowIdx(nextIdx);
  };

  return (
    <ImgContainer
      isMouseMove={isMouseDown}
      onMouseDown={handleMouseDown}
      onMouseMove={handleMouseMove}
      onMouseUp={handleMouseUp}
    >
      {MOCK_IMGS.map((imgSrc, idx) => (
        <StyleImg src={imgSrc} key={idx} isDisplay={idx === nextIdx ? true : false} />
      ))}
    </ImgContainer>
  );
}

export default CarImg;

const ImgContainer = styled.div<{ isMouseMove: number }>`
  position: relative;
  width: 592px;
  height: 325px;
  cursor: ${({ isMouseMove }) => (isMouseMove ? 'grabbing' : 'grab')};
`;

const StyleImg = styled.img<{ isDisplay: boolean }>`
  position: absolute;
  width: 100%;
  height: 100%;
  display: ${({ isDisplay }) => !isDisplay && 'none'};
  pointer-events: none;
`;
