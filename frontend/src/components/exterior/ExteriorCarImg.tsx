import { MouseEventHandler, useLayoutEffect, useRef, useState } from 'react';
import { css } from '@emotion/react';
import styled from '@emotion/styled';
import { Loading } from '@/components/common';
import { useRotate } from '@/components/exterior/hooks/useRotate';
import { ReactComponent as Ellipse } from '@/assets/shape/ellipse.svg';

interface Props {
  name: string;
  imgUrlList: string[];
}

function ExteriorCarImg({ name, imgUrlList }: Props) {
  const imageCache = useRef(new Set<string>());
  const { state, handleMouseDown, handleMouseMove, handleMouseUp } = useRotate();
  const preventEventDefault: MouseEventHandler<HTMLDivElement> = (e) => e.preventDefault();

  const [isImageLoading, setIsImageLoading] = useState(true);

  useLayoutEffect(() => {
    if (imageCache.current.has(name)) return;

    let count = 0;
    setIsImageLoading(true);
    imgUrlList.forEach((src) => {
      const image = new Image();
      image.src = src;
      image.onload = () => {
        count++;
        if (count === imgUrlList.length) {
          setTimeout(() => {
            setIsImageLoading(false);
            imageCache.current.add(name);
          }, 500);
        }
      };
      image.onerror = () => {
        count++;
        if (count === imgUrlList.length) {
          setIsImageLoading(false);
        }
      };
    });
  }, [imgUrlList, name]);

  return (
    <ExteriorCarContainer>
      {isImageLoading ? (
        <Loading />
      ) : (
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
      )}
      <Ellipse css={StyleEllipse}></Ellipse>
      <p>360°</p>
    </ExteriorCarContainer>
  );
}

export default ExteriorCarImg;

const ExteriorCarContainer = styled.div`
  ${({ theme }) => theme.flex.flexCenterCol}
  ${({ theme }) => theme.typography.TextKRMedium16}
  align-items: center;
  position: relative;
  margin: 0 auto;
  width: 100%;
  height: 100%;

  & > p {
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
