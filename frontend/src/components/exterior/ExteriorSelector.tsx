import { Dispatch, SetStateAction } from 'react';
import styled from '@emotion/styled';
import type { ExteriorResponse } from '@/types/interface';
import { Icon, MainSelector } from '@/components/common';
import { ExteriorCard } from '@/components/exterior';
import { usePagination } from '@/hooks';

interface Props {
  exteriorList: ExteriorResponse[];
  selectedIdx: number;
  setSelectedIdx: Dispatch<SetStateAction<number>>;
}

function ExteriorSelector({ exteriorList, selectedIdx, setSelectedIdx }: Props) {
  const { currentSlice, hasPaigination, isStartPage, isEndPage, currentPage, totalPage, prevPage, nextPage } =
    usePagination({
      data: exteriorList,
    });

  if (!hasPaigination) return;

  return (
    <MainSelector title='외장 색상을 선택해주세요'>
      <ExteriorList>
        {currentSlice.map(({ name, hexCode, choiceRatio, price }, idx) => (
          <ExteriorCard
            key={idx}
            colorName={name}
            colorHexCode={hexCode}
            choiceRatio={choiceRatio}
            price={price}
            isClicked={selectedIdx === currentPage * 4 + idx}
            onClick={() => setSelectedIdx(currentPage * 4 + idx)}
          />
        ))}
      </ExteriorList>
      <ButtonContainer isEndPage={isEndPage} isStartPage={isStartPage}>
        <Icon className='left-arrow' iconType='ArrowRight' size={24} onClick={prevPage} />
        <span>
          {currentPage + 1} / {totalPage}
        </span>
        <Icon className='right-arrow' iconType='ArrowRight' size={24} onClick={nextPage} />
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

const ButtonContainer = styled.div<{ isStartPage: boolean; isEndPage: boolean }>`
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
    fill: ${({ theme, isStartPage }) => (isStartPage ? theme.colors.gray200 : theme.colors.gray600)};
    pointer-events: ${({ isStartPage }) => isStartPage && 'none'};
    cursor: pointer;
  }

  .right-arrow {
    fill: ${({ theme, isEndPage }) => (isEndPage ? theme.colors.gray200 : theme.colors.gray600)};
    pointer-events: ${({ isEndPage }) => isEndPage && 'none'};
    cursor: pointer;
  }
`;
