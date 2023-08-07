import TrimPage from './TrimPage';
import { PageCarousel as Carousel } from '@/components/carousel';
import { useSafeContext } from '@/hooks';
import { SlideContext } from '@/providers/SlideProvider';

function Pages() {
  const { currentSlide } = useSafeContext(SlideContext);

  return (
    <Carousel currentSlide={currentSlide}>
      <Carousel.Slide>
        <TrimPage />
      </Carousel.Slide>
      <Carousel.Slide>2</Carousel.Slide>
      <Carousel.Slide>3</Carousel.Slide>
      <Carousel.Slide>4</Carousel.Slide>
      <Carousel.Slide>5</Carousel.Slide>
      <Carousel.Slide>6</Carousel.Slide>
    </Carousel>
  );
}

export default Pages;
