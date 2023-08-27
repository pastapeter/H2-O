import { useRef } from 'react';
import styled from '@emotion/styled';
import type { DefaultOptionResponse } from '@/types/response';
import { Flex, Typography } from '@/components/common';
import { OptionCard } from '@/components/option/utils';
import { getImagePreloader } from '@/utils/image';

interface Props {
  optionList: DefaultOptionResponse[];
  handleClickOptionCard: (idx: number) => () => void;
}

function DefaultOptionSelector({ optionList, handleClickOptionCard }: Props) {
  const imageLoader = useRef(getImagePreloader());

  const handleMouseOver = (images: string[]) => {
    imageLoader.current(images);
  };

  if (!optionList.length)
    return (
      <Flex alignItems='center' justifyContent='center' height={200}>
        <Typography font='HeadKRBold18' color='gray900'>
          검색결과가 없습니다.
        </Typography>
      </Flex>
    );

  return (
    <OptionContainer>
      {optionList.map((option) => {
        const { id, image } = option;
        return (
          <OptionCard.Default
            key={id}
            info={option}
            onClick={handleClickOptionCard(id)}
            onMouseOver={() => handleMouseOver([image])}
          />
        );
      })}
    </OptionContainer>
  );
}

export default DefaultOptionSelector;

const OptionContainer = styled.div`
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  gap: 16px;
`;
