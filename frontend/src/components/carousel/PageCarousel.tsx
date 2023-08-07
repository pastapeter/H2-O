import { PropsWithChildren, memo } from 'react';
import styled from '@emotion/styled';

interface CarouselProps {
  currentSlide: number;
}
function Carousel({ children, currentSlide }: PropsWithChildren<CarouselProps>) {
  return (
    <CarouselContainer>
      <CarouselSlideList currentSlide={currentSlide}>{children}</CarouselSlideList>
    </CarouselContainer>
  );
}

function Slide({ children }: PropsWithChildren) {
  return <CarouselSlide>{children}</CarouselSlide>;
}

Carousel.Slide = memo(Slide);
export default Carousel;

const CarouselContainer = styled.div`
  background-color: ${({ theme }) => theme.colors.blueBg};
  overflow-x: hidden;
  width: 100%;
`;

const CarouselSlideList = styled.ul<Pick<CarouselProps, 'currentSlide'>>`
  display: flex;
  gap: 12px;
  transition: transform 1s ease-in-out;
  transform: translateX(calc(-${({ currentSlide }) => currentSlide} * (100% + 12px)));
`;

const CarouselSlide = styled.li`
  width: 100%;
  min-height: calc(100vh - 60px);
  flex-shrink: 0;
`;
