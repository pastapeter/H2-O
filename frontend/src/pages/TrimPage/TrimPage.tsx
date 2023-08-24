import { Fragment, memo, useEffect, useRef, useState } from 'react';
import { css } from '@emotion/react';
import type { Offsets } from '@/types';
import type { TrimResponse } from '@/types/response';
import { getTrims } from '@/apis/trim';
import { Banner, Loading } from '@/components/common';
import { GuidePopup, PracticalInfo, TrimImageList, TrimSelector } from '@/components/trim';
import { useFetcher, useSafeContext, useToggle } from '@/hooks';
import { hasLocalStorageItem, setLocalStorageItem } from '@/utils/localStorage';
import { SelectionContext } from '@/providers/SelectionProvider';

const TRIM_DEFAULT_IDX = 1;
const DISABLE_GUIDE_VIEW = 'disable-guide-view';
const BANNER_COLOR = 'linear-gradient(180deg, rgba(162, 199, 231, 0.2) 24.92%, rgba(255, 255, 255, 0) 61.36%), #fff';

function TrimPage() {
  const isGuideViewDisabled = !hasLocalStorageItem(DISABLE_GUIDE_VIEW);
  const { selectionInfo, dispatch } = useSafeContext(SelectionContext);
  const { status: isOpenPopup, setOff } = useToggle(isGuideViewDisabled);
  const [offsets, setOffsets] = useState<Offsets>({ offsetX: 0, offsetY: 0 });
  const [selectedTrim, setSelectedTrim] = useState<TrimResponse | null>(null);

  const { isLoading, data: trimList } = useFetcher({
    fetchFn: () => getTrims(selectionInfo.model.id),
    deferTime: 500,
    onSuccess: (data) => {
      const selected = data[TRIM_DEFAULT_IDX];
      setSelectedTrim(selected);

      const { id, name, price } = selected;
      dispatch({ type: 'SET_TRIM', payload: { id, name, price } });
    },
  });

  const targetRef = useRef<HTMLDivElement | null>(null);

  useEffect(() => {
    if (!targetRef.current || isLoading) return;

    const { left, top } = targetRef.current.getBoundingClientRect();
    setOffsets({ offsetX: left, offsetY: top });
  }, [targetRef.current, isLoading]);

  const handleClosePopup = () => {
    setOff();
    setLocalStorageItem(DISABLE_GUIDE_VIEW, 'true');
  };

  const handleSelectTrim = (trim: TrimResponse) => {
    setSelectedTrim(trim);
  };

  if (isLoading || !selectedTrim) return <Loading fullPage />;

  const { id, name, description, images, options } = selectedTrim;

  return (
    <Fragment>
      <Banner title={name} subTitle={description} backgroundColor={BANNER_COLOR}>
        <PracticalInfo options={options} ref={targetRef} />
        <GuidePopup isOpen={isOpenPopup} onClose={handleClosePopup} offsets={offsets}>
          <PracticalInfo
            options={options}
            css={css`
              background-color: white;
            `}
          />
        </GuidePopup>
        <TrimImageList imageSrcList={images} />
      </Banner>
      {trimList && <TrimSelector trimList={trimList} selectedTrimId={id} onSelectTrim={handleSelectTrim} />}
    </Fragment>
  );
}

const _TrimPage = memo(TrimPage);
export default _TrimPage;
