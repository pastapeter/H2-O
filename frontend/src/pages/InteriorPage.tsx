import { Fragment, memo, useState } from 'react';
import { css } from '@emotion/react';
import { Banner, Footer } from '@/components/common';
import InteriorSelector from '@/components/interior/InteriorSelector';

const mocks = Array.from({ length: 12 }, (_, i) => ({
  id: i + 1,
  name: '퀼팅천연(블랙)',
  choiceRatio: 38,
  price: 0,
  fabricImage: '/images/interior-option.png',
  bannerImage: '/images/interior-black.png',
}));

function InteriorPage() {
  const [selectedId, setSelectedId] = useState(1);

  const handleClickOption = (id: number) => {
    setSelectedId(id);
  };

  const { name, bannerImage } = mocks[selectedId - 1];

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
      <InteriorSelector optionList={mocks} selectedId={selectedId} onClickOption={handleClickOption} />
      <Footer />
    </Fragment>
  );
}

const _InteriorPage = memo(InteriorPage);
export default _InteriorPage;
