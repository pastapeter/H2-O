import { HTMLAttributes, useEffect, useRef, useState } from 'react';
import styled from '@emotion/styled';
import { Flex } from '@/components/common';

interface Props extends HTMLAttributes<HTMLDivElement> {
  text: string;
  length: number;
}

function OverFlowRowText({ text, length, ...restProps }: Props) {
  const [isRotate, setIsRotate] = useState(false);
  const textRef = useRef<HTMLSpanElement>(null);

  useEffect(() => {
    if (textRef.current?.offsetWidth) setIsRotate(textRef.current?.offsetWidth > length);
  }, [textRef.current?.offsetWidth]);

  return (
    <RowContainer maxWidth={length} isRotate={isRotate} {...restProps}>
      <span className='text-row' ref={textRef}>
        {text}
        {isRotate && <> {text}</>}
      </span>
    </RowContainer>
  );
}

function OverFlowColumnText({ text, length, ...restProps }: Props) {
  const [isRotate, setIsRotate] = useState(false);
  const textRef = useRef<HTMLParagraphElement>(null);

  useEffect(() => {
    if (textRef.current?.offsetHeight) setIsRotate(textRef.current?.offsetHeight > length);
  }, [textRef.current?.offsetHeight]);

  return (
    <ColumnContainer
      maxHeight={length}
      nowHeight={textRef.current ? textRef.current.offsetHeight : length}
      isRotate={isRotate}
      {...restProps}
    >
      <p className='text-column' ref={textRef}>
        {text}
      </p>
    </ColumnContainer>
  );
}

export { OverFlowRowText, OverFlowColumnText };

const RowContainer = styled(Flex)<{ maxWidth: number; isRotate: boolean }>`
  width: ${({ maxWidth, isRotate }) => (isRotate ? `${maxWidth}px` : '100%')};
  overflow: hidden;
  white-space: nowrap;

  .text-row:hover {
    animation: ${({ isRotate }) => isRotate && `rotateRight 10s linear infinite;`};
    @keyframes rotateRight {
      100% {
        transform: translateX(-50%);
      }
    }
  }
`;

const ColumnContainer = styled(Flex)<{ maxHeight: number; nowHeight: number; isRotate: boolean }>`
  width: 490px;
  height: ${({ maxHeight, isRotate }) => (isRotate ? `${maxHeight}px` : '100%')};
  display: inline-block;
  overflow: hidden;

  .text-column:hover {
    animation: ${({ isRotate }) => isRotate && `rotateTop 5s linear forwards;`};
    @keyframes rotateTop {
      100% {
        transform: ${({ maxHeight, nowHeight }) => `translateY(${maxHeight - nowHeight}px)`};
      }
    }
  }
`;
