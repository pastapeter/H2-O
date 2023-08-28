import { Fragment } from 'react';
import styled from '@emotion/styled';
import { useSafeContext } from './hooks';
import { SlideContext } from './providers/SlideProvider';
import { Pages } from '@/pages';
import { Header, PriceStaticBar as _PriceStaticBar } from '@/components/common';

function App() {
  const { currentSlide } = useSafeContext(SlideContext);

  return (
    <Fragment>
      <Header />
      <PriceStaticBar currentSlide={currentSlide} isComplete={currentSlide === 5} />
      <Main>
        <Pages />
      </Main>
    </Fragment>
  );
}

export default App;

const Main = styled.main`
  padding-top: 60px;
`;

const PriceStaticBar = styled(_PriceStaticBar)<{ currentSlide: number }>`
  display: ${({ currentSlide }) => currentSlide === 0 && 'none'};
  position: fixed;
  top: 76px;
  left: 50%;
  transform: translateX(-50%);
  z-index: 5;
`;
