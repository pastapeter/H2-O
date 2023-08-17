import styled from '@emotion/styled';
import type { DefaultOptionResponse } from '@/types/interface';
import { Flex, Typography } from '@/components/common';
import { OptionCard } from '@/components/option/utils';

interface Props {
  optionList: DefaultOptionResponse[];
  handleClickOptionCard: (idx: number) => () => void;
}

function DefaultOptionSelector({ optionList, handleClickOptionCard }: Props) {
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
      {optionList.map((opt) => (
        <OptionCard.Default key={opt.id} info={opt} onClick={handleClickOptionCard(opt.id)} />
      ))}
    </OptionContainer>
  );
}

export default DefaultOptionSelector;

const OptionContainer = styled.div`
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  gap: 16px;
`;
