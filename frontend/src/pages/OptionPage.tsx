import { Fragment, memo, useState } from 'react';
import { css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import type { DetailedOptionResponse, DetailedPackageOptionResponse } from '@/types/interface';
import { CategoryButton, Flex, Footer, Icon, MainSelector } from '@/components/common';
import { DefaultOptionSelector, ExtraOptionSelector, OptionBanner } from '@/components/option';
import { useFilter } from '@/components/option/hooks';
import {
  DETAILED_OPTION_LIST,
  defaultOptionCategoryList,
  extraOptionCategoryList,
} from '@/components/option/mock/mock';

function OptionPage() {
  const theme = useTheme();

  const {
    state,
    handleClickDefaultOption,
    handleClickExtraOption,
    handleClickExtraCategory,
    handleClickDefaultCategory,
    handleChangeInput,
    handleClickSearchButton,
  } = useFilter();
  const { isExtraOption, extraCategoryIdx, defaultCategoryIdx, extraOptionList, defaultOptionList, input } = state;

  const [data, setData] = useState<DetailedOptionResponse | DetailedPackageOptionResponse>(DETAILED_OPTION_LIST[0]);
  const [hasHMGData, setHasHMGData] = useState(true);

  const handleClickOptionCard = (idx: number, hasHMGData: boolean) => () => {
    setHasHMGData(hasHMGData);
    setData(DETAILED_OPTION_LIST[idx]);
  };

  return (
    <Fragment>
      <OptionBanner hasHMGData={hasHMGData} optionInfo={data} />
      <MainSelector>
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
                    key={idx}
                    isClicked={idx === extraCategoryIdx}
                    onClick={handleClickExtraCategory(idx)}
                  >
                    {category}
                  </CategoryButton>
                ))
              : defaultOptionCategoryList.map((category, idx) => (
                  <CategoryButton
                    key={idx}
                    isClicked={idx === defaultCategoryIdx}
                    onClick={handleClickDefaultCategory(idx)}
                  >
                    {category}
                  </CategoryButton>
                ))}
          </Flex>
        </ButtonContainer>
        {isExtraOption ? (
          <ExtraOptionSelector dataList={extraOptionList} handleClickOptionCard={handleClickOptionCard} />
        ) : (
          <DefaultOptionSelector dataList={defaultOptionList} handleClickOptionCard={handleClickOptionCard} />
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
