import { useState } from 'react';
import styled from '@emotion/styled';
import type { DefaultOptionResponse, ExtraOptionResponse } from '@/types/interface';
import { Flex, Typography } from '@/components/common';
import { OptionCard } from '@/components/option/utils';

interface Props {
  isExtraOption: boolean;
  dataList: ExtraOptionResponse[] | DefaultOptionResponse[];
  handleClickOptionCard: (idx: number, hasHMGData: boolean) => () => void;
}

function OptionSelector({ isExtraOption, dataList, handleClickOptionCard }: Props) {
  const [checkOptionList, setCheckOptionList] = useState<number[]>([]);

  const addToOptionList = (idx: number) => {
    setCheckOptionList((prevList) => [...prevList, idx]);
  };
  const removeFromOptionList = (idx: number) => {
    setCheckOptionList((prevList) => prevList.filter((num) => num !== idx));
  };

  if (!dataList.length)
    return (
      <Flex alignItems='center' justifyContent='center' height={200}>
        <Typography font='HeadKRBold18' color='gray900'>
          검색결과가 없습니다.
        </Typography>
      </Flex>
    );

  if (isExtraOption)
    return (
      <OptionContainer>
        {dataList.map((opt) => (
          <OptionCard
            key={opt.id}
            type='extra'
            info={opt}
            isChecked={checkOptionList.includes(opt.id)}
            addOption={addToOptionList}
            removeOption={removeFromOptionList}
            onClick={handleClickOptionCard(opt.id, opt.containsHmgData)}
          />
        ))}
      </OptionContainer>
    );

  return (
    <OptionContainer>
      {dataList.map((opt) => (
        <OptionCard
          key={opt.id}
          type='default'
          info={opt}
          onClick={handleClickOptionCard(opt.id, opt.containsHmgData)}
        />
      ))}
    </OptionContainer>
  );
}

export default OptionSelector;

const OptionContainer = styled.div`
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  gap: 16px;
`;
