import { render, screen } from '@/tests/test-util';
import { PageCarousel as Carousel } from '@/components/carousel';

describe('PageCarousel 컴포넌트 테스트', () => {
  it('PageCarousel이 정상적으로 렌더링 된다.', () => {
    render(
      <Carousel currentSlide={1}>
        <Carousel.Slide>페이지1</Carousel.Slide>
        <Carousel.Slide>페이지2</Carousel.Slide>
        <Carousel.Slide>페이지3</Carousel.Slide>
      </Carousel>,
    );

    expect(screen.getByTestId('carousel')).toBeInTheDocument();
  });

  it('PageCarousel내 페이지 슬라이드가 정상적으로 렌더링 된다.', () => {
    render(
      <Carousel currentSlide={1}>
        <Carousel.Slide>페이지1</Carousel.Slide>
        <Carousel.Slide>페이지2</Carousel.Slide>
        <Carousel.Slide>페이지3</Carousel.Slide>
      </Carousel>,
    );

    expect(screen.getByText('페이지1')).toBeInTheDocument();
    expect(screen.getByText('페이지2')).toBeInTheDocument();
    expect(screen.getByText('페이지3')).toBeInTheDocument();
  });

  it('PageCarousel 스냅샷 테스트', () => {
    render(
      <Carousel currentSlide={1}>
        <Carousel.Slide>페이지1</Carousel.Slide>
        <Carousel.Slide>페이지2</Carousel.Slide>
        <Carousel.Slide>페이지3</Carousel.Slide>
      </Carousel>,
    );

    expect(screen.getByTestId('carousel')).toMatchSnapshot();
  });
});
