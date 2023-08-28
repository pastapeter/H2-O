import { ChangeEventHandler, HTMLAttributes, KeyboardEventHandler, useEffect, useState } from 'react';
import styled from '@emotion/styled';
import { DefaultOptionResponse, ExtraOptionResponse } from '@/types/response';
import { Flex, Icon } from '@/components/common';
import { OverFlowRowText } from '@/components/option/utils';

interface Props extends HTMLAttributes<HTMLDivElement> {
  isExtraOption?: boolean;
  input: string;
  optionList: ExtraOptionResponse[] | DefaultOptionResponse[];
  filterList: (value: string) => void;
}

function SearchBar({ isExtraOption = false, input, optionList, filterList }: Props) {
  const [dropDownList, setDropDownList] = useState<ExtraOptionResponse[] | DefaultOptionResponse[]>([]);
  const [isActive, setIsActive] = useState(false);
  const [itemIdx, setItemIdx] = useState(-1);

  const handleChangeInput: ChangeEventHandler<HTMLInputElement> = (e) => {
    filterList(e.target.value);
    if (e.target.value === '') setIsActive(false);
    else optionList.length && setIsActive(true);
  };

  const handleKeyBoard: KeyboardEventHandler<HTMLInputElement> = (e) => {
    const listLength = optionList.length;
    if (!listLength) return;

    switch (e.key) {
      case 'ArrowDown':
        itemIdx < listLength - 1 && setItemIdx((prev) => prev + 1);
        break;
      case 'ArrowUp':
        itemIdx > -1 && setItemIdx((prev) => prev - 1);
        break;
      case 'Enter':
        itemIdx >= 0 && itemIdx <= listLength - 1 && handleSearchItem(optionList[itemIdx].name);
    }
  };

  const completeSearch = () => {
    setIsActive(false);
    setItemIdx(-1);
  };

  const handleSearchItem = (value: string) => {
    filterList(value);
    completeSearch();
  };

  useEffect(() => {
    !input ? setDropDownList([]) : setDropDownList(optionList);
  }, [optionList]);

  return (
    <Flex flexDirection='column' position='relative'>
      <InputContainer>
        <Flex justifyContent='center' alignItems='center' width={335}>
          <StyledInput
            type='text'
            value={input}
            placeholder={
              isExtraOption ? '옵션명, 해시태그, 카테고리로 검색해보세요.' : '옵션명, 카테고리로 검색해보세요.'
            }
            onChange={handleChangeInput}
            onKeyUp={handleKeyBoard}
          />
        </Flex>
        <StyledIcon justifyContent='center' alignItems='center'>
          <Icon iconType='CarbonSearch' size={18} color='gray700' onClick={() => handleSearchItem(input)} />
        </StyledIcon>
      </InputContainer>
      {isActive && (
        <DropDownContainer>
          {dropDownList.map((item, idx) => (
            <DropDownItem key={item.name} onClick={() => handleSearchItem(item.name)} isActive={idx === itemIdx}>
              <OverFlowRowText text={item.name} length={300} />
            </DropDownItem>
          ))}
        </DropDownContainer>
      )}
    </Flex>
  );
}

export default SearchBar;

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
  width: 300px;
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
  width: 65px;
  height: 100%;
`;

const DropDownContainer = styled.ul`
  ${({ theme }) => theme.flex.flexCenterCol}

  list-style-type: none;
  position: absolute;
  top: 100%;
  z-index: 3;
  width: 335px;
  background-color: ${({ theme }) => theme.colors.white};
  border: 1px solid ${({ theme }) => theme.colors.gray200};
  border-top: 0;
  border-radius: 2px;
`;

const DropDownItem = styled.li<{ isActive: boolean }>`
  ${({ theme }) => theme.typography.TextKRRegular12}
  color: ${({ theme, isActive }) => (isActive ? theme.colors.gray900 : theme.colors.gray600)};
  height: 30px;
  width: 300px;
  display: flex;
  align-items: center;

  &:hover {
    color: ${({ theme }) => theme.colors.gray900};
  }
`;
