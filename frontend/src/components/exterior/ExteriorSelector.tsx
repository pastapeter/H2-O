import styled from '@emotion/styled';
import type { ExteriorColorResponse } from '@/types/response';
import { Icon, MainSelector } from '@/components/common';
import { ExteriorCard } from '@/components/exterior';
import { usePagination } from '@/hooks';

interface Props {
  exteriorList: ExteriorColorResponse[];
  selectedColor: ExteriorColorResponse;
  onSelectColor: (color: ExteriorColorResponse) => void;
}

function ExteriorSelector({ exteriorList, selectedColor, onSelectColor }: Props) {
  const { currentSlice, hasPagination, isStartPage, isEndPage, currentPage, totalPage, prevPage, nextPage } =
    usePagination({
      data: exteriorList,
    });

  return (
    <MainSelector title='외장 색상을 선택해주세요'>
      <ExteriorList>
        {currentSlice.map((color) => {
          const { id, name, hexCode, choiceRatio, price } = color;

          return (
            <ExteriorCard
              key={id}
              colorName={name}
              colorHexCode={hexCode}
              choiceRatio={choiceRatio}
              price={price}
              isClicked={id === selectedColor.id}
              onClick={() => onSelectColor(color)}
            />
          );
        })}
      </ExteriorList>
      {hasPagination && (
        <ButtonContainer isEndPage={isEndPage} isStartPage={isStartPage}>
          <Icon className='left-arrow' iconType='ArrowRight' size={24} onClick={prevPage} />
          <span>
            {currentPage + 1}/{totalPage}
          </span>
          <Icon className='right-arrow' iconType='ArrowRight' size={24} onClick={nextPage} />
        </ButtonContainer>
      )}
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
