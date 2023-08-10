import { MouseEventHandler } from 'react';
import { css } from '@emotion/react';
import styled from '@emotion/styled';
import { useRotate } from './hooks';
import { ReactComponent as Ellipse } from '@/assets/shape/ellipse.svg';

interface Props {
  imgUrlList: string[];
}

function ExteriorCarImg({ imgUrlList }: Props) {
  const { state, handleMouseDown, handleMouseMove, handleMouseUp } = useRotate();
  const preventEventDefault: MouseEventHandler<HTMLDivElement> = (e) => e.preventDefault();

  return (
    <ExteriorCarContainer>
      <ImgContainer
        isMouseDown={state.isMouseDown}
        onMouseDown={handleMouseDown}
        onMouseMove={state.isMouseDown ? handleMouseMove : preventEventDefault}
        onMouseUp={handleMouseUp}
      >
        {imgUrlList.map((imgSrc, idx) => (
          <StyleImg src={imgSrc} key={idx} isDisplay={idx === state.nextImgIdx ? true : false} />
        ))}
      </ImgContainer>
      <Ellipse css={StyleEllipse}></Ellipse>
      <p>360°</p>
    </ExteriorCarContainer>
  );
}

export default ExteriorCarImg;

const ExteriorCarContainer = styled.div`
  ${({ theme }) => theme.flex.flexEndCol}
  ${({ theme }) => theme.typography.TextKRMedium16}
  align-items: center;
  position: relative;
  margin: 0 auto;

  p {
    position: absolute;
    bottom: 22px;
    background-color: ${({ theme }) => theme.colors.blueBg};
    width: 61px;
    text-align: center;
    pointer-events: none;
  }
`;

const ImgContainer = styled.div<{ isMouseDown: boolean }>`
  width: 592px;
  height: 325px;
  transform: scale(0.9);
  cursor: ${({ isMouseDown }) => (isMouseDown ? 'grabbing' : 'grab')};
`;

const StyleImg = styled.img<{ isDisplay: boolean }>`
  display: ${({ isDisplay }) => !isDisplay && 'none'};
  position: absolute;
  top: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
`;

const StyleEllipse = css`
  position: absolute;
  bottom: 34px;
  pointer-events: none;
`;
