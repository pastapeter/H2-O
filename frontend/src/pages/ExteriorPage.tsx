import { memo, useState } from 'react';
import { Banner } from '@/components/common';
import { ExteriorCarImg, ExteriorSelector } from '@/components/exterior';

const numList = Array.from({ length: 60 }, (_, i) => i + 1);
const mockImages = numList.map((idx) => `/images/car3d/image_${idx.toString().padStart(3, '0')}.png`);

const mockExterior = Array.from({ length: 11 }, (_, i) => ({
  id: i + 1,
  name: `어비스 블랙펄 ${i + 1}`,
  choiceRatio: 38,
  price: 0,
  hexCode: '#1c2d3e',
  images: mockImages,
}));

function ExteriorPage() {
  const [selectedIdx, setSelectedIdx] = useState(0);

  return (
    <>
      <Banner title={mockExterior[selectedIdx].name} subTitle='외장색상' backgroundColor='transparent'>
        <ExteriorCarImg imgUrlList={mockExterior[selectedIdx].images} />
      </Banner>
      <ExteriorSelector exteriorList={mockExterior} selectedIdx={selectedIdx} setSelectedIdx={setSelectedIdx} />
    </>
  );
}

const _ExteriorPage = memo(ExteriorPage);
export default _ExteriorPage;
