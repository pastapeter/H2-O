import { useState } from 'react';
import { css } from '@emotion/react';
import styled from '@emotion/styled';

interface Props {
  imageSrcList: string[];
}

interface ImageProps {
  isActive: boolean;
}

function TrimImageList({ imageSrcList }: Props) {
  const [activeIdx, setActiveIdx] = useState(0);

  const handleImageClick = (idx: number) => {
    setActiveIdx(idx);
  };

  const images = imageSrcList.slice(0, 3);

  return (
    <TrimImageListContainer>
      {images.map((src, idx) => (
        <Image key={idx} isActive={idx === activeIdx} onClick={() => handleImageClick(idx)}>
          <img src={src} alt={`이미지 ${idx + 1}`} />
        </Image>
      ))}
    </TrimImageListContainer>
  );
}

export default TrimImageList;

const TrimImageListContainer = styled.ul`
  position: relative;
  display: flex;
  gap: 16px;
  height: 100%;
`;

const Image = styled.li<ImageProps>`
  position: relative;
  height: 360px;

  & > img {
    width: ${({ isActive }) => (isActive ? '504px' : '71px')};
    height: 100%;
    object-fit: cover;
    object-position: center;
    transition: width 0.7s ease-in-out;
  }

  &::after {
    ${({ theme }) => theme.typography.HeadKRBold12}
    color: rgba(255, 255, 255, 0.7);
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 100%;
    background-color: none;
    transition: background-color 0.5s ease-in-out;
  }

  ${({ isActive }) =>
    !isActive &&
    css`
      cursor: pointer;

      &:hover:after {
        content: 'click';
        background-color: rgba(0, 0, 0, 0.5);
      }
    `}
`;
