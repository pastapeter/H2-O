import { Fragment, memo, useState } from 'react';
import styled from '@emotion/styled';
import type { ExteriorColorResponse } from '@/types/interface';
import { getExteriorColors } from '@/apis/exterior';
import { Banner, Footer, PriceStaticBar as _PriceStaticBar } from '@/components/common';
import { ExteriorCarImg, ExteriorSelector } from '@/components/exterior';
import { useFetcher, useSafeContext } from '@/hooks';
import { SelectionContext } from '@/providers/SelectionProvider';

function ExteriorPage() {
  const { selectionInfo, dispatch } = useSafeContext(SelectionContext);
  const [selectedColor, setSelectedColor] = useState<ExteriorColorResponse | null>(null);
  const trimId = selectionInfo.trim?.id;

  const {
    isLoading,
    data: exteriorColorList,
    error,
  } = useFetcher({
    fetchFn: () => getExteriorColors(trimId as number),
    enabled: !!selectionInfo.trim,
    onSuccess: (data) => {
      const selected = data[0];
      setSelectedColor(selected);

      const { id, name, price, images, hexCode } = selected;
      dispatch({ type: 'SET_EXTERIOR_COLOR', payload: { id, name, price, image: images[0], colorCode: hexCode } });
    },
  });

  const handleSelectColor = (color: ExteriorColorResponse) => {
    const { id, name, price, images, hexCode } = color;

    setSelectedColor(color);
    dispatch({ type: 'SET_EXTERIOR_COLOR', payload: { id, name, price, image: images[0], colorCode: hexCode } });
  };

  if (isLoading || !selectedColor) return <div>로딩 ㅋ</div>;
  if (error) return <div>에러 ㅋ</div>;

  const { name, images } = selectedColor;

  return (
    <Fragment>
      <Banner title={name} subTitle='외장색상'>
        <ExteriorCarImg name={name} imgUrlList={images} />
      </Banner>
      {exteriorColorList && (
        <ExteriorSelector
          exteriorList={exteriorColorList}
          selectedColor={selectedColor}
          onSelectColor={handleSelectColor}
        />
      )}
      <Footer />
      <PriceStaticBar />
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
