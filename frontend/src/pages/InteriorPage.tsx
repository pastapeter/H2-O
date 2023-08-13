import { Fragment, memo, useEffect, useState } from 'react';
import { css } from '@emotion/react';
import type { InteriorColorResponse } from '@/types/interface';
import { Banner, Footer } from '@/components/common';
import { InteriorSelector } from '@/components/interior';
import { useSafeContext } from '@/hooks';
import { SelectionContext } from '@/providers/SelectionProvider';

const mocks: InteriorColorResponse[] = Array.from({ length: 12 }, (_, i) => ({
  id: i + 1,
  name: '퀼팅천연(블랙)',
  choiceRatio: 38,
  price: 0,
  fabricImage: '/images/interior-option.png',
  bannerImage: '/images/interior-black.png',
}));

function InteriorPage() {
  const [selectedColor, setSelectedColor] = useState<InteriorColorResponse>(mocks[0]);
  const { dispatch } = useSafeContext(SelectionContext);
  const { id, name, price, bannerImage, fabricImage } = selectedColor;

  useEffect(() => {
    dispatch({ type: 'SET_INTERIOR_COLOR', payload: { id, name, price, image: bannerImage, fabricImage } });
  }, []);

  const handleSelectColor = (color: InteriorColorResponse) => {
    const { id, name, price, bannerImage, fabricImage } = color;

    setSelectedColor(color);
    dispatch({ type: 'SET_INTERIOR_COLOR', payload: { id, name, price, image: bannerImage, fabricImage } });
  };

  return (
    <Fragment>
      <Banner
        title={name}
        subTitle='내장색상'
        isTitleColorWhite
        css={css`
          background: url(${bannerImage}) no-repeat;
          background-size: cover;
        `}
      />
      <InteriorSelector optionList={mocks} selectedColor={selectedColor} onSelectColor={handleSelectColor} />
      <Footer />
    </Fragment>
  );
}

const _InteriorPage = memo(InteriorPage);
export default _InteriorPage;
