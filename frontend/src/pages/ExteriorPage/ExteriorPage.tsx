import { Fragment, memo, useState } from 'react';
import type { ExteriorColorResponse } from '@/types/response';
import { getExteriorColors } from '@/apis/exterior';
import { Banner, Footer, Loading } from '@/components/common';
import { ExteriorCarImg, ExteriorSelector } from '@/components/exterior';
import { useFetcher, useSafeContext } from '@/hooks';
import { SelectionContext } from '@/providers/SelectionProvider';

function ExteriorPage() {
  const { selectionInfo, dispatch } = useSafeContext(SelectionContext);
  const [selectedColor, setSelectedColor] = useState<ExteriorColorResponse | null>(null);
  const trimId = selectionInfo.trim?.id;

  const { isLoading, data: exteriorColorList } = useFetcher({
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

  if (isLoading || !selectedColor) return <Loading />;

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
    </Fragment>
  );
}

const _ExteriorPage = memo(ExteriorPage);
export default _ExteriorPage;
