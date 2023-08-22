import { useEffect } from 'react';
import styled from '@emotion/styled';
import type { ExtraOptionResponse } from '@/types/interface';
import { Flex, Typography } from '@/components/common';
import { OptionCard } from '@/components/option/utils';
import { useSafeContext } from '@/hooks';
import useSetList from '@/hooks/useSetList';
import { OptionInfo, SelectionContext } from '@/providers/SelectionProvider';

interface Props {
  optionList: ExtraOptionResponse[];
  handleClickOptionCard: (idx: number, isPackage: boolean) => () => void;
}

function ExtraOptionSelector({ optionList, handleClickOptionCard }: Props) {
  const { selectionInfo, dispatch } = useSafeContext(SelectionContext);

  const { dataList, addData, removeData, hasData } = useSetList<Omit<OptionInfo, 'isQuotation'>>({
    initDataList: selectionInfo.extraOptions?.optionList.map((item) => {
      const { isQuotation, ...rest } = item;
      return rest;
    }),
  });

  const compareDataList = () => {
    const globalOptionIdx = selectionInfo.extraOptions?.optionList.map((item) => item.id).sort((a, b) => a - b) || [];
    const localOptionIdx = dataList.map((item) => item.id).sort((a, b) => a - b);

    return (
      globalOptionIdx.length === localOptionIdx.length &&
      globalOptionIdx.every((value, idx) => value === localOptionIdx[idx])
    );
  };

  useEffect(() => {
    if (!selectionInfo.extraOptions) {
      dispatch({ type: 'SET_EXTRA_OPTIONS', payload: [] });
      return;
    }

    const newOptionList = dataList.map((item) => {
      return (
        selectionInfo.extraOptions?.optionList.find((data) => data.id === item.id) || { ...item, isQuotation: false }
      );
    });

    //  newOptionList랑 selectionInfo.extraOptions랑 같을 경우는 dispatch 금지
    !compareDataList() && dispatch({ type: 'SET_EXTRA_OPTIONS', payload: newOptionList });
  }, [dataList]);

  useEffect(() => {
    // 전역 상태 변화에 따른 옵션페이지 리렌더링
    if (!selectionInfo.extraOptions) return;

    // 전역 상태에는 있는데 리스트에 없는 경우 데이터 추가
    const dataListId = dataList.map((item) => item.id);
    selectionInfo.extraOptions.optionList.forEach(
      (item) =>
        !dataListId.includes(item.id) &&
        addData({ id: item.id, name: item.name, price: item.price, image: item.image, isPackage: item.isPackage }),
    );

    // 전역 상태에 없는데 리스트에 있는 경우 데이터 삭제
    const selectionInfoId = selectionInfo.extraOptions.optionList.map((item) => item.id);
    dataList.forEach((item) => !selectionInfoId.includes(item.id) && removeData(item));
  }, [selectionInfo.extraOptions?.optionList]);

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
          isChecked={hasData({
            id: opt.id,
            name: opt.name,
            price: opt.price,
            image: opt.image,
            isPackage: opt.isPackage,
          })}
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
