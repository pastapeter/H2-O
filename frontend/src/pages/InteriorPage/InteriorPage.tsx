import { Fragment, memo, useState } from 'react';
import { css } from '@emotion/react';
import type { InteriorColorResponse } from '@/types/response';
import { getInteriorColors } from '@/apis/interior';
import { Banner, Footer, Loading } from '@/components/common';
import { InteriorSelector } from '@/components/interior';
import { useFetcher, useSafeContext } from '@/hooks';
import { SelectionContext } from '@/providers/SelectionProvider';

function InteriorPage() {
  const { selectionInfo, dispatch } = useSafeContext(SelectionContext);
  const [selectedColor, setSelectedColor] = useState<InteriorColorResponse | null>(null);
  const trimId = selectionInfo.trim?.id;

  const { isLoading, data: interiorColorList } = useFetcher({
    fetchFn: () => getInteriorColors(trimId as number),
    enabled: !!selectionInfo.trim,
    onSuccess: (data) => {
      const selected = data[0];
      setSelectedColor(selected);

      const { id, name, price, bannerImage, fabricImage } = selected;
      dispatch({ type: 'SET_INTERIOR_COLOR', payload: { id, name, price, image: bannerImage, fabricImage } });
    },
  });

  const handleSelectColor = (color: InteriorColorResponse) => {
    const { id, name, price, bannerImage, fabricImage } = color;

    setSelectedColor(color);
    dispatch({ type: 'SET_INTERIOR_COLOR', payload: { id, name, price, image: bannerImage, fabricImage } });
  };

  if (isLoading || !selectedColor) return <Loading />;

  const { name, bannerImage } = selectedColor;

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
      {interiorColorList && (
        <InteriorSelector
          optionList={interiorColorList}
          selectedColor={selectedColor}
          onSelectColor={handleSelectColor}
        />
      )}
      <Footer />
    </Fragment>
  );
}

const _InteriorPage = memo(InteriorPage);
export default _InteriorPage;
