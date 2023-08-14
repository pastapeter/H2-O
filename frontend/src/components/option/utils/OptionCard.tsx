import { HTMLAttributes, MouseEventHandler, useState } from 'react';
import { css } from '@emotion/react';
import styled from '@emotion/styled';
import { DefaultOptionResponse, ExtraOptionResponse } from '@/types/interface';
import { Card, Flex, HMGTag, HashTag, Typography } from '@/components/common';
import { CheckIcon } from '@/components/option/utils';
import { toPriceFormatString } from '@/utils/string';

interface Props extends HTMLAttributes<HTMLDivElement> {
  info: DefaultOptionResponse | ExtraOptionResponse;
  isChecked?: boolean;
  addOption?: (idx: number) => void;
  removeOption?: (idx: number) => void;
}

const isExtraOption = (info: DefaultOptionResponse | ExtraOptionResponse): info is ExtraOptionResponse => {
  return typeof info === 'object' && Object.prototype.hasOwnProperty.call(info, 'price');
};

function OptionCard({ info, isChecked, addOption, removeOption, ...restProps }: Props) {
  const [isActive, setIsActive] = useState(isChecked);

  const handleClickIcon: MouseEventHandler<HTMLButtonElement> = () => {
    setIsActive((prev) => !prev);
    isActive ? removeOption && removeOption(info.id) : addOption && addOption(info.id);
  };

  return (
    <OptionCardContainer {...restProps}>
      <ImgContainer url={info.image} flexDirection='column' justifyContent='flex-end' position='relative'>
        <Flex flexDirection='row' gap={`8px`} paddingLeft={`12px`} paddingBottom={`8px`}>
          {info.hashTags.map((hashTag, idx) => (
            <HashTag key={idx} title={hashTag} />
          ))}
        </Flex>
        {info.containsHmgData && <HMGTag css={HMGTagPosition} />}
      </ImgContainer>
      {isExtraOption(info) ? (
        <MainContainer>
          <Flex flexDirection='column'>
            <Typography font='TextKRRegular12' color='gray700'>
              <span className='ratio'>{info.choiceRatio}%</span>가 선택했어요
            </Typography>
            <Typography color='gray900' font='HeadKRMedium16'>
              {info.name}
            </Typography>
          </Flex>
          <Typography color='gray900' font='HeadKRMedium16'>
            {toPriceFormatString(info.price)}
          </Typography>
          <CheckIcon isActive={isActive ?? false} css={IconPosition} onClick={handleClickIcon} />
        </MainContainer>
      ) : (
        <MainContainer>
          <Typography color='gray900' font='HeadKRMedium16'>
            {info.name}
          </Typography>
          <Typography color='gray500' font='TextKRMedium14'>
            기본 옵션
          </Typography>
        </MainContainer>
      )}
    </OptionCardContainer>
  );
}

export default OptionCard;

const OptionCardContainer = styled(Card)`
  ${({ theme }) => theme.flex.flexCenterCol}
  background-color: ${({ theme }) => theme.colors.gray50};
  border-radius: 2px;
  border: 1px solid ${({ theme }) => theme.colors.gray200};
  width: 244px;
  height: 278px;

  &:active {
    background-color: ${({ theme }) => theme.colors.cardBg};
  }
`;

const ImgContainer = styled(Flex)<{ url: string }>`
  background-image: ${({ url }) => `url(${url})`};
  background-size: cover;
  background-position: center center;
  width: 100%;
  height: 162px;
`;

const MainContainer = styled.div`
  ${({ theme }) => theme.flex.flexBetweenCol}
  position: relative;
  width: 100%;
  height: 116px;
  padding: 16px 19px 12px 13px;

  .ratio {
    color: ${({ theme }) => theme.colors.activeBlue};
  }
`;

const IconPosition = css`
  position: absolute;
  bottom: 16px;
  right: 16px;
`;

const HMGTagPosition = css`
  position: absolute;
  top: 0px;
  right: 0px;
`;
