import { Fragment, memo, useEffect, useState } from 'react';
import { css } from '@emotion/react';
import styled from '@emotion/styled';
import type { ExteriorColorResponse } from '@/types/interface';
import { Banner, Footer, PriceStaticBar as _PriceStaticBar } from '@/components/common';
import { ExteriorCarImg, ExteriorSelector } from '@/components/exterior';
import { useSafeContext } from '@/hooks';
import { SelectionContext } from '@/providers/SelectionProvider';

const numList = Array.from({ length: 60 }, (_, i) => i + 1);
const mockImages = numList.map((idx) => `/images/car3d/image_${idx.toString().padStart(3, '0')}.png`);

const mocks: ExteriorColorResponse[] = Array.from({ length: 11 }, (_, i) => ({
  id: i + 1,
  name: `어비스 블랙펄 ${i + 1}`,
  choiceRatio: 38,
  price: 0,
  hexCode: '#1c2d3e',
  images: mockImages,
}));

function ExteriorPage() {
  const { dispatch } = useSafeContext(SelectionContext);
  const [selectedColor, setSelectedColor] = useState(mocks[0]);

  const { id, name, price, images, hexCode } = selectedColor;

  useEffect(() => {
    dispatch({ type: 'SET_EXTERIOR_COLOR', payload: { id, name, price, image: images[0], colorCode: hexCode } });
  }, []);

  const handleSelectColor = (color: ExteriorColorResponse) => {
    const { id, name, price, images, hexCode } = color;

    setSelectedColor(color);
    dispatch({ type: 'SET_EXTERIOR_COLOR', payload: { id, name, price, image: images[0], colorCode: hexCode } });
  };

  return (
    <Fragment>
      <Banner title={name} subTitle='외장색상'>
        <ExteriorCarImg imgUrlList={images} />
      </Banner>
      <ExteriorSelector exteriorList={mocks} selectedColor={selectedColor} onSelectColor={handleSelectColor} />
      <Footer />
      <PriceStaticBar
        isComplete={false}
        nowPrice={4100}
        css={css`
          position: fixed;
          top: 16px;
          left: 50%;
          transform: translateX(-50%);
        `}
      />
    </Fragment>
  );
}

const _ExteriorPage = memo(ExteriorPage);
export default _ExteriorPage;

const PriceStaticBar = styled(_PriceStaticBar)`
  position: fixed;
  top: 16px;
  left: 50%;
  transform: translateX(-50%);
`;
