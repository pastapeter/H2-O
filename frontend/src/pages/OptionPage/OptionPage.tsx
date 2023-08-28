import { Fragment, memo, useEffect, useState } from 'react';
import { css } from '@emotion/react';
import styled from '@emotion/styled';
import type { GeneralOptionResponse, PackageOptionResponse } from '@/types/response';
import { getOptionInfo, getOptionList, getPackageInfo } from '@/apis/option';
import { CategoryButton, Flex, Footer, Loading, MainSelector } from '@/components/common';
import {
  DefaultOptionSelector,
  ExtraOptionSelector,
  GeneralOptionBanner,
  PackageOptionBanner,
} from '@/components/option';
import { DEFAULT_CATEGORY_OPTION_LIST, EXTRA_OPTION_CATEGORY_LIST } from '@/components/option/constants';
import { useFilter } from '@/components/option/hooks';
import { SearchBar } from '@/components/option/utils';
import { useFetcher, useSafeContext } from '@/hooks';
import { SelectionContext } from '@/providers/SelectionProvider';

const checkPackageOption = (data: GeneralOptionResponse | PackageOptionResponse): data is PackageOptionResponse => {
  return typeof data === 'object' && Object.prototype.hasOwnProperty.call(data, 'components');
};

function OptionPage() {
  const { selectionInfo } = useSafeContext(SelectionContext);
  const [data, setData] = useState<GeneralOptionResponse | PackageOptionResponse>();
  const trimId = selectionInfo.trim?.id;
  const {
    state,
    setOptionList,
    handleClickDefaultOption,
    handleClickExtraOption,
    handleClickExtraCategory,
    handleClickDefaultCategory,
    handleChangeInput,
  } = useFilter();

  const { isLoading } = useFetcher({
    fetchFn: () => getOptionList(trimId as number),
    enabled: !!selectionInfo.trim,
    onSuccess: (data) => {
      setOptionList(data.extraOptionList, data.defaultOptionList);
    },
  });

  const { isExtraOption, extraCategoryIdx, defaultCategoryIdx, extraOptionList, defaultOptionList, input } = state;

  const handleClickOptionCard = (idx: number) => async () => {
    try {
      const response = await getOptionInfo(trimId as number, idx);
      setData(response);
    } catch (err) {
      if (err instanceof Error) {
        throw new Error('기본 옵션 카드 선택 오류');
      }
    }
  };

  const handleClickExtraOptionCard = (idx: number, isPackage: boolean) => async () => {
    try {
      const response = await (isPackage ? getPackageInfo(trimId as number, idx) : getOptionInfo(trimId as number, idx));
      setData(response);
    } catch (err) {
      if (err instanceof Error) {
        throw new Error('추가 옵션 카드 선택 오류');
      }
    }
  };

  // 옵션 카드 selector이 바뀔 경우 배너는 리스트에 젤 첫번쨰 카드의 정보
  useEffect(() => {
    (async function () {
      if (!extraOptionList[0] || !defaultOptionList[0]) return;
      const response = isExtraOption
        ? extraOptionList[0].isPackage
          ? await getPackageInfo(trimId as number, extraOptionList[0].id)
          : await getOptionInfo(trimId as number, extraOptionList[0].id)
        : await getOptionInfo(trimId as number, defaultOptionList[0].id);

      setData(response);
    })();
  }, [extraOptionList, defaultOptionList, isExtraOption]);

  if (isLoading || !extraOptionList || !defaultOptionList || !data) return <Loading />;

  return (
    <Fragment>
      {/* 배너 */}
      {checkPackageOption(data) ? (
        <PackageOptionBanner key={data.name} optionInfo={data} />
      ) : (
        <GeneralOptionBanner key={data.name} optionInfo={data} />
      )}
      <MainSelector>
        {/* 카테고리 버튼 + 검색창 */}
        <ButtonContainer>
          <Flex justifyContent='space-between'>
            <Flex gap={24}>
              <Tab isActive={isExtraOption} onClick={handleClickExtraOption}>
                추가옵션
              </Tab>
              <Tab isActive={!isExtraOption} onClick={handleClickDefaultOption}>
                기본옵션
              </Tab>
            </Flex>
            {isExtraOption
              ? extraCategoryIdx === 0 && (
                  <SearchBar
                    isExtraOption={true}
                    optionList={extraOptionList}
                    input={input}
                    filterList={handleChangeInput}
                  />
                )
              : defaultCategoryIdx === 0 && (
                  <SearchBar optionList={defaultOptionList} input={input} filterList={handleChangeInput} />
                )}
          </Flex>
          <Flex gap={8}>
            {isExtraOption
              ? EXTRA_OPTION_CATEGORY_LIST.map((category, idx) => (
                  <CategoryButton
                    key={category}
                    isClicked={idx === extraCategoryIdx}
                    onClick={handleClickExtraCategory(idx)}
                  >
                    {category}
                  </CategoryButton>
                ))
              : DEFAULT_CATEGORY_OPTION_LIST.map((category, idx) => (
                  <CategoryButton
                    key={category}
                    isClicked={idx === defaultCategoryIdx}
                    onClick={handleClickDefaultCategory(idx)}
                  >
                    {category}
                  </CategoryButton>
                ))}
          </Flex>
        </ButtonContainer>
        {/* 옵션 카드 리스트 */}
        {isExtraOption ? (
          <ExtraOptionSelector optionList={extraOptionList} handleClickOptionCard={handleClickExtraOptionCard} />
        ) : (
          <DefaultOptionSelector optionList={defaultOptionList} handleClickOptionCard={handleClickOptionCard} />
        )}
      </MainSelector>
      <Footer isSticky={true} />
    </Fragment>
  );
}

const _OptionPage = memo(OptionPage);
export default _OptionPage;

const ButtonContainer = styled.div`
  display: flex;
  flex-direction: column;
  gap: 8px;
  padding-bottom: 16px;
`;

// TODO: tab 분리하기 (+ NAVBAR TAB)
const Tab = styled.button<{ isActive: boolean }>`
  ${({ theme }) => theme.flex.flexCenterCol}
  position: relative;
  ${({ theme, isActive }) => (isActive ? theme.typography.HeadKRMedium18 : theme.typography.TextKRMedium18)}
  color: ${({ theme, isActive }) => (isActive ? theme.colors.gray900 : theme.colors.gray200)};
  height: 32px;

  ${({ isActive, theme }) => {
    if (isActive) {
      return css`
        &::after {
          position: absolute;
          bottom: 0;
          content: '';
          width: 18px;
          height: 2px;
          background-color: ${theme.colors.primary500};
        }
      `;
    }
  }}
`;
