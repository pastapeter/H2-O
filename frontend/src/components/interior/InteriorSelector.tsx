import { useRef } from 'react';
import { css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import type { InteriorColorResponse } from '@/types/response';
import { Flex, Icon, Typography } from '@/components/common';
import { InteriorCard } from '@/components/interior';
import { usePagination } from '@/hooks';
import { getImagePreloader } from '@/utils/image';

interface Props {
  optionList: InteriorColorResponse[];
  selectedColor: InteriorColorResponse;
  onSelectColor: (color: InteriorColorResponse) => void;
}

function InteriorSelector({ optionList, selectedColor, onSelectColor }: Props) {
  const imageLoaderRef = useRef(getImagePreloader());
  const { currentSlice, hasPagination, isStartPage, isEndPage, currentPage, totalPage, prevPage, nextPage } =
    usePagination({
      data: optionList,
    });
  const { colors } = useTheme();

  const pagingButtonStyle = (isLast: boolean) => css`
    fill: ${isLast ? colors.gray200 : colors.gray600};
    cursor: ${isLast ? 'not-allowed' : 'pointer'};
  `;

  const handleMouseOver = (image: string) => {
    imageLoaderRef.current([image]);
  };

  return (
    <Container>
      <div>
        <Flex justifyContent='space-between' alignItems='center' marginBottom={12}>
          <h2>내장 색상을 선택해주세요.</h2>
          {hasPagination && (
            <Flex alignItems='center' gap={8}>
              <Icon css={pagingButtonStyle(isStartPage)} iconType='ArrowLeft' color='gray600' onClick={prevPage} />
              <Typography font='HeadKRMedium14' color='gray500'>{`${currentPage + 1}/${totalPage}`}</Typography>
              <Icon css={pagingButtonStyle(isEndPage)} iconType='ArrowRight' color='gray600' onClick={nextPage} />
            </Flex>
          )}
        </Flex>
        <Flex gap={16} width='100%'>
          {currentSlice.map((color) => {
            const { id, fabricImage, bannerImage, ...props } = color;

            return (
              <InteriorCard
                key={id}
                image={fabricImage}
                isSelected={id === selectedColor.id}
                onClick={() => onSelectColor(color)}
                onMouseOver={() => handleMouseOver(bannerImage)}
                {...props}
              />
            );
          })}
        </Flex>
      </div>
    </Container>
  );
}

export default InteriorSelector;

const Container = styled.div`
  position: relative;
  width: 100%;
  min-height: calc(100vh - 420px);
  padding-top: 16px;
  background-color: white;

  & > div {
    max-width: 1024px;
    width: 100%;
    margin: 0 auto;
  }

  h2 {
    ${({ theme }) => theme.typography.HeadKRMedium16}
  }
`;
