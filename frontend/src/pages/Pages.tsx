import { ExteriorPage } from './ExteriorPage';
import { InteriorPage } from './InteriorPage';
import { ModelPage } from './ModelPage';
import { OptionPage } from './OptionPage';
import { ResultPage } from './ResultPage';
import { TrimPage } from './TrimPage';
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
      <Carousel.Slide>
        <ModelPage />
      </Carousel.Slide>
      <Carousel.Slide>
        <ExteriorPage />
      </Carousel.Slide>
      <Carousel.Slide>
        <InteriorPage />
      </Carousel.Slide>
      <Carousel.Slide>
        <OptionPage />
      </Carousel.Slide>
      <Carousel.Slide>
        <ResultPage />
      </Carousel.Slide>
    </Carousel>
  );
}

export default Pages;
