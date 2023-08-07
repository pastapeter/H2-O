import { memo } from 'react';
import { Banner } from '@/components/common';
import { PracticalInfo, TrimImageList, TrimSelector } from '@/components/trim';

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

function TrimPage() {
  return (
    <>
      <Banner title='Le Blanc' subTitle='기본에 충실한 팰리세이드'>
        <PracticalInfo options={mockOptions} />
        <TrimImageList imageSrcList={mockImages} />
      </Banner>
      <TrimSelector trimList={mockTrims} />
    </>
  );
}

const _TrimPage = memo(TrimPage);
export default _TrimPage;
