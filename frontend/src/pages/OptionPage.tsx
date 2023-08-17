import { Fragment, memo, useEffect, useState } from 'react';
import { css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import type { GeneralOptionResponse, PackageOptionResponse } from '@/types/interface';
import { getOptionInfo, getOptionList, getPackageInfo } from '@/apis/option';
import { CategoryButton, Flex, Footer, Icon, Loading, MainSelector } from '@/components/common';
import { DefaultOptionSelector, ExtraOptionSelector, OptionBanner } from '@/components/option';
import { useFilter } from '@/components/option/hooks';
import { defaultOptionCategoryList, extraOptionCategoryList } from '@/components/option/mock/mock';
import { useFetcher, useSafeContext } from '@/hooks';
import { SelectionContext } from '@/providers/SelectionProvider';

const checkPackageOption = (data: GeneralOptionResponse | PackageOptionResponse): data is PackageOptionResponse => {
  return typeof data === 'object' && Object.prototype.hasOwnProperty.call(data, 'components');
};

function OptionPage() {
  const theme = useTheme();
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
    handleClickSearchButton,
  } = useFilter();

  const { isLoading, error } = useFetcher({
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

  // 옵션 카드 selector이 바뀔 경우 배너 정보 변화
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

  if (isLoading || !extraOptionList || !defaultOptionList || !data) return <Loading fullPage={true} />;
  if (error) return <div>에러 ㅋ</div>;

  return (
    <Fragment>
      {/* 배너 */}
      {checkPackageOption(data) ? (
        <OptionBanner.PackageOption optionInfo={data} />
      ) : (
        <OptionBanner.GeneralOption optionInfo={data} />
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
            <InputContainer>
              <Flex justifyContent='center' alignItems='center' width={`100%`}>
                <StyledInput
                  type='text'
                  value={input}
                  placeholder={
                    isExtraOption ? '옵션명, 해시태그, 카테고리로 검색해보세요.' : '옵션명, 카테고리로 검색해보세요.'
                  }
                  onChange={handleChangeInput}
                />
              </Flex>
              <StyledIcon justifyContent='center' alignItems='center' onClick={handleClickSearchButton}>
                <Icon iconType='CarbonSearch' size={18} color={theme.colors.gray700} />
              </StyledIcon>
            </InputContainer>
          </Flex>
          <Flex gap={8}>
            {isExtraOption
              ? extraOptionCategoryList.map((category, idx) => (
                  <CategoryButton
                    key={category}
                    isClicked={idx === extraCategoryIdx}
                    onClick={handleClickExtraCategory(idx)}
                  >
                    {category}
                  </CategoryButton>
                ))
              : defaultOptionCategoryList.map((category, idx) => (
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

const InputContainer = styled.div`
  ${({ theme }) => theme.flex.flexBetweenRow}
  width: 400px;
  height: 32px;
  border: 1px solid ${({ theme }) => theme.colors.gray200};
  border-radius: 2px;
`;

const StyledInput = styled.input`
  ${({ theme }) => theme.typography.TextKRRegular12}
  color: ${({ theme }) => theme.colors.gray900};
  width: 308px;
  height: 24px;
  border: none;

  &::placeholder {
    color: ${({ theme }) => theme.colors.gray600};
  }
  &:focus {
    outline: none;
  }
`;

const StyledIcon = styled(Flex)`
  background-color: ${({ theme }) => theme.colors.gray100};
  border-left: 1px solid ${({ theme }) => theme.colors.gray200};
  width: 67px;
  height: 100%;
`;
