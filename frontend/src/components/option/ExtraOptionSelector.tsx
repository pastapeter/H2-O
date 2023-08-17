import { useEffect } from 'react';
import styled from '@emotion/styled';
import type { ExtraOptionResponse } from '@/types/interface';
import { Flex, Typography } from '@/components/common';
import { OptionCard } from '@/components/option/utils';
import { useSafeContext } from '@/hooks';
import useSetList from '@/hooks/useSetList';
import { SelectionContext, SelectionInfoWithImage } from '@/providers/SelectionProvider';

interface Props {
  optionList: ExtraOptionResponse[];
  handleClickOptionCard: (idx: number, isPackage: boolean) => () => void;
}

function ExtraOptionSelector({ optionList, handleClickOptionCard }: Props) {
  const { selectionInfo, dispatch } = useSafeContext(SelectionContext);

  const { dataList, addData, removeData, hasData } = useSetList<SelectionInfoWithImage>({
    initDataList: selectionInfo.extraOptions?.optionList,
  });

  useEffect(() => {
    dispatch({ type: 'SET_EXTRA_OPTIONS', payload: dataList });
  }, [dataList]);

  // global state 변화화면 강제 리렌더링
  useEffect(() => {
    if (!selectionInfo.extraOptions) return;
    selectionInfo.extraOptions.optionList.forEach((item) => !hasData(item) && addData(item));
  }, [selectionInfo.extraOptions]);

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
        <OptionCard.Extra
          key={opt.id}
          info={opt}
          isChecked={hasData({ id: opt.id, name: opt.name, price: opt.price, image: opt.image })}
          addOption={addData}
          removeOption={removeData}
          onClick={handleClickOptionCard(opt.id, opt.isPackage)}
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
