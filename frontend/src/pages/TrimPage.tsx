import { memo, useEffect, useRef, useState } from 'react';
import { css } from '@emotion/react';
import type { Offsets } from '@/types';
import type { Trim, TrimResponse } from '@/types/interface';
import { Banner } from '@/components/common';
import { GuidePopup, PracticalInfo, TrimImageList, TrimSelector } from '@/components/trim';
import { useSafeContext, useToggle } from '@/hooks';
import { hasLocalStorageItem, setLocalStorageItem } from '@/utils/localStorage';
import { SelectionContext } from '@/providers/SelectionProvider';

const mocks: TrimResponse = {
  trims: [
    {
      id: 1,
      name: 'Exclusive',
      description: '기본기를 갖춘 베이직한 팰리세이드',
      price: 40440000,
      images: ['/images/exterior.png', '/images/interior.png', '/images/wheel.png'],
      options: [
        {
          dataLabel: '안전 하차 보조',
          frequency: 50,
        },
        {
          dataLabel: '후측방 충돌 경고',
          frequency: 40,
        },
        {
          dataLabel: '후방 교차 충돌방지 보조',
          frequency: 30,
        },
      ],
    },
    {
      id: 2,
      name: 'Le Blanc',
      description: '실용적인 사양의 경제적인 팰리세이드',
      price: 43460000,
      images: ['/images/exterior.png', '/images/interior.png', '/images/wheel.png'],
      options: [
        {
          dataLabel: '안전 하차 보조',
          frequency: 50,
        },
        {
          dataLabel: '후측방 충돌 경고',
          frequency: 40,
        },
        {
          dataLabel: '후방 교차 충돌방지 보조',
          frequency: 30,
        },
      ],
    },
    {
      id: 3,
      name: 'Prestige',
      description: '합리적인 필수 사양을 더한 팰리세이드',
      price: 47720000,
      images: ['/images/exterior.png', '/images/interior.png', '/images/wheel.png'],
      options: [
        {
          dataLabel: '안전 하차 보조',
          frequency: 50,
        },
        {
          dataLabel: '후측방 충돌 경고',
          frequency: 40,
        },
        {
          dataLabel: '후방 교차 충돌방지 보조',
          frequency: 30,
        },
      ],
    },
    {
      id: 4,
      name: 'Caligraphy',
      description: '프리미엄한 경험을 선사하는 팰리세이드',
      price: 52540000,
      images: ['/images/exterior.png', '/images/interior.png', '/images/wheel.png'],
      options: [
        {
          dataLabel: '안전 하차 보조',
          frequency: 50,
        },
        {
          dataLabel: '후측방 충돌 경고',
          frequency: 40,
        },
        {
          dataLabel: '후방 교차 충돌방지 보조',
          frequency: 30,
        },
      ],
    },
  ],
};

const DISABLE_GUIDE_VIEW = 'disable-guide-view';
const BANNER_COLOR = 'linear-gradient(180deg, rgba(162, 199, 231, 0.2) 24.92%, rgba(255, 255, 255, 0) 61.36%), #fff';

function TrimPage() {
  const isGuideViewDisabled = !hasLocalStorageItem(DISABLE_GUIDE_VIEW);
  const { dispatch } = useSafeContext(SelectionContext);
  const { status: isOpenPopup, setOff } = useToggle(isGuideViewDisabled);
  const [offsets, setOffsets] = useState<Offsets>({ offsetX: 0, offsetY: 0 });
  const [selectedTrim, setSelectedTrim] = useState<Trim>(mocks.trims[1]);

  const { id, name, price, description, images, options } = selectedTrim;

  const targetRef = useRef<HTMLDivElement | null>(null);

  useEffect(() => {
    dispatch({ type: 'SET_TRIM', payload: { id, name, price } });
  }, []);

  useEffect(() => {
    if (!targetRef.current) return;

    const { left, top } = targetRef.current.getBoundingClientRect();
    setOffsets({ offsetX: left, offsetY: top });
  }, [targetRef.current]);

  const handleClosePopup = () => {
    setOff();
    setLocalStorageItem(DISABLE_GUIDE_VIEW, 'true');
  };

  const handleSelectTrim = (trim: Trim) => {
    setSelectedTrim(trim);
  };

  return (
    <>
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
      <TrimSelector trimList={mocks.trims} selectedTrimId={id} onSelectTrim={handleSelectTrim} />
    </>
  );
}

const _TrimPage = memo(TrimPage);
export default _TrimPage;
