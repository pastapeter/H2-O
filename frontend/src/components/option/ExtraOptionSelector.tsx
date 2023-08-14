import { useEffect, useState } from 'react';
import styled from '@emotion/styled';
import type { ExtraOptionResponse } from '@/types/interface';
import { Flex, Typography } from '@/components/common';
import { OptionCard } from '@/components/option/utils';
import { useSafeContext } from '@/hooks';
import { SelectionContext } from '@/providers/SelectionProvider';

interface Props {
  dataList: ExtraOptionResponse[];
  handleClickOptionCard: (idx: number, hasHMGData: boolean) => () => void;
}

function ExtraOptionSelector({ dataList, handleClickOptionCard }: Props) {
  const [checkOptionList, setCheckOptionList] = useState<number[]>([]);
  const { dispatch } = useSafeContext(SelectionContext);

  const addToOptionList = (idx: number) => {
    setCheckOptionList((prevList) => [...prevList, idx]);
  };

  const removeFromOptionList = (idx: number) => {
    setCheckOptionList((prevList) => prevList.filter((num) => num !== idx));
  };

  useEffect(() => {
    dispatch({
      type: 'SET_EXTRA_OPTIONS',
      payload: checkOptionList.map((idx) => ({
        id: dataList[idx].id,
        name: dataList[idx].name,
        price: dataList[idx].price,
        image: dataList[idx].image,
      })),
    });
  }, [checkOptionList]);

  if (!dataList.length)
    return (
      <Flex alignItems='center' justifyContent='center' height={200}>
        <Typography font='HeadKRBold18' color='gray900'>
          검색결과가 없습니다.
        </Typography>
      </Flex>
    );

  return (
    <OptionContainer>
      {dataList.map((opt) => (
        <OptionCard
          key={opt.id}
          info={opt}
          isChecked={checkOptionList.includes(opt.id)}
          addOption={addToOptionList}
          removeOption={removeFromOptionList}
          onClick={handleClickOptionCard(opt.id, opt.containsHmgData)}
        />
      ))}
    </OptionContainer>
  );
}

export default ExtraOptionSelector;

const OptionContainer = styled.div`
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  gap: 16px;
`;
