import { memo, useEffect, useRef, useState } from 'react';
import { css } from '@emotion/react';
import { Offsets } from '@/types';
import { Banner } from '@/components/common';
import { GuidePopup, PracticalInfo, TrimImageList, TrimSelector } from '@/components/trim';
import useToggle from '@/hooks/useToggle';
import { hasLocalStorageItem, setLocalStorageItem } from '@/utils/localStorage';

const mockOptions = [
  { name: '안전 하차 보조', count: 42 },
  { name: '후측방 충돌 경고', count: 42 },
  { name: '후방 교차 충돌방지 보조', count: 42 },
];

const mockImages = ['/images/exterior.png', '/images/interior.png', '/images/wheel.png'];

const mockTrims = [
  {
    id: 1,
    description: '기본기를 갖춘 베이직한 팰리세이드',
    title: 'Exclusive',
    price: 40440000,
  },
  {
    id: 2,
    description: '실용적인 사양의 경제적인 팰리세이드',
    title: 'Le Blanc',
    price: 43460000,
  },
  {
    id: 3,
    description: '합리적인 필수 사양을 더한 팰리세이드',
    title: 'Prestige',
    price: 47720000,
  },
  {
    id: 4,
    description: '프리미엄한 경험을 선사하는 팰리세이드',
    title: 'Caligraphy',
    price: 52540000,
  },
];

const DISABLE_GUIDE_VIEW = 'disable-guide-view';
const BANNER_COLOR = 'linear-gradient(180deg, rgba(162, 199, 231, 0.2) 24.92%, rgba(255, 255, 255, 0) 61.36%), #fff';

function TrimPage() {
  const isGuideViewDisabled = !hasLocalStorageItem(DISABLE_GUIDE_VIEW);
  const { status: isOpenPopup, setOff } = useToggle(isGuideViewDisabled);
  const [offsets, setOffsets] = useState<Offsets>({ offsetX: 0, offsetY: 0 });
  const targetRef = useRef<HTMLDivElement | null>(null);

  useEffect(() => {
    if (!targetRef.current) return;

    const { left, top } = targetRef.current.getBoundingClientRect();
    setOffsets({ offsetX: left, offsetY: top });
  }, [targetRef.current]);

  const closePopup = () => {
    setOff();
    setLocalStorageItem(DISABLE_GUIDE_VIEW, 'true');
  };

  return (
    <>
      <Banner title='Le Blanc' subTitle='기본에 충실한 팰리세이드' backgroundColor={BANNER_COLOR}>
        <PracticalInfo options={mockOptions} ref={targetRef} />
        <GuidePopup isOpen={isOpenPopup} onClose={closePopup} offsets={offsets}>
          <PracticalInfo
            options={mockOptions}
            css={css`
              background-color: white;
            `}
          />
        </GuidePopup>
        <TrimImageList imageSrcList={mockImages} />
      </Banner>
      <TrimSelector trimList={mockTrims} />
    </>
  );
}

const _TrimPage = memo(TrimPage);
export default _TrimPage;
