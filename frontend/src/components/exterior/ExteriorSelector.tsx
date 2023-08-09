import { Dispatch, SetStateAction, useState } from 'react';
import styled from '@emotion/styled';
import type { ExteriorResponse } from '@/types/interface';
import { Icon, MainSelector } from '@/components/common';
import { ExteriorCard } from '@/components/exterior';
import { theme } from '@/styles/theme';

interface Props {
  exteriorList: ExteriorResponse[];
  selectedIdx: number;
  setSelectedIdx: Dispatch<SetStateAction<number>>;
}

function ExteriorSelector({ exteriorList, selectedIdx, setSelectedIdx }: Props) {
  const [page, setPage] = useState(0);
  const MAX_PAGE = Math.ceil(exteriorList.length / 4) - 1;
  const FIRST_PAGE = 0;

  return (
    <MainSelector title='외장 색상을 선택해주세요'>
      <ExteriorList>
        {exteriorList.slice(page * 4, (page + 1) * 4).map((item, idx) => (
          <ExteriorCard
            key={idx}
            colorName={item.name}
            colorHexCode={item.hexCode}
            choiceRatio={item.choiceRatio}
            price={item.price}
            isClicked={selectedIdx === page * 4 + idx}
            onClick={() => setSelectedIdx(page * 4 + idx)}
          />
        ))}
      </ExteriorList>
      <ButtonContainer page={page} maxPage={MAX_PAGE} firstPage={FIRST_PAGE}>
        <Icon className='left-arrow' iconType='ArrowRight' size={24} onClick={() => setPage((p) => p - 1)} />
        <span>
          {page + 1} / {MAX_PAGE + 1}
        </span>
        <Icon className='right-arrow' iconType='ArrowRight' size={24} onClick={() => setPage((p) => p + 1)} />
      </ButtonContainer>
    </MainSelector>
  );
}

export default ExteriorSelector;

const ExteriorList = styled.ul`
  display: flex;
  gap: 16px;
  width: 100%;
`;

const ButtonContainer = styled.div<{ page: number; maxPage: number; firstPage: number }>`
  ${({ theme }) => theme.flex.flexEndRow}
  align-items: center;
  position: absolute;
  top: 16px;
  margin: 0 auto;
  max-width: 1024px;
  width: 100%;
  text-align: center;
  gap: 16px;

  span {
    ${({ theme }) => theme.typography.TextKRRegular14}
  }

  .left-arrow {
    transform: rotate(180deg);
    fill: ${({ page, firstPage }) => (page === firstPage ? theme.colors.gray200 : theme.colors.gray600)};
    pointer-events: ${({ page, firstPage }) => page === firstPage && 'none'};
    cursor: pointer;
  }

  .right-arrow {
    fill: ${({ page, maxPage }) => (page === maxPage ? theme.colors.gray200 : theme.colors.gray600)};
    pointer-events: ${({ page, maxPage }) => page === maxPage && 'none'};
    cursor: pointer;
  }
`;
