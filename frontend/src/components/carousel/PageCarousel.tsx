import type { PropsWithChildren, RefObject } from 'react';
import { createContext, memo, useRef } from 'react';
import styled from '@emotion/styled';

interface CarouselProps {
  currentSlide: number;
}
function Carousel({ children, currentSlide }: PropsWithChildren<CarouselProps>) {
  return (
    <CarouselContainer data-testid='carousel'>
      <CarouselSlideList currentSlide={currentSlide}>{children}</CarouselSlideList>
    </CarouselContainer>
  );
}

type PageContextType = RefObject<HTMLLIElement>;

export const PageContext = createContext<PageContextType | null>(null);

function Slide({ children }: PropsWithChildren) {
  const pageRef = useRef<HTMLLIElement | null>(null);

  return (
    <PageContext.Provider value={pageRef}>
      <CarouselSlide ref={pageRef}>{children}</CarouselSlide>
    </PageContext.Provider>
  );
}

Slide.displayName = 'Slide';

Carousel.Slide = memo(Slide);
export default Carousel;

const CarouselContainer = styled.div`
  background-color: ${({ theme }) => theme.colors.blueBg};
  width: 100%;
  overflow-x: hidden;
`;

const CarouselSlideList = styled.ul<Pick<CarouselProps, 'currentSlide'>>`
  display: flex;
  gap: 12px;
  height: calc(100vh - 60px);
  transition: transform 1s ease-in-out;
  transform: translateX(calc(-${({ currentSlide }) => currentSlide} * (100% + 12px)));
`;

const CarouselSlide = styled.li`
  position: relative;
  width: 100%;
  min-height: calc(100vh - 60px);
  flex-shrink: 0;
  transform: translateX(0);
  overflow-x: hidden;
  overflow-y: scroll;
  -webkit-transform: translate3d(0, 0, 0);
`;
