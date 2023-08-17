import { HTMLAttributes, MouseEventHandler, PropsWithChildren, useEffect, useState } from 'react';
import { css } from '@emotion/react';
import styled from '@emotion/styled';
import type { DefaultOptionResponse, ExtraOptionResponse } from '@/types/interface';
import { Card, Flex, HMGTag, HashTag, Typography } from '@/components/common';
import { CheckBox } from '@/components/option/utils';
import { toPriceFormatString } from '@/utils/string';
import { SelectionInfoWithImage } from '@/providers/SelectionProvider';

interface CardProps {
  image: string;
  hashTags: string[];
  containsHmgData: boolean;
}

function OptionCard({ children, image, hashTags, containsHmgData, ...restProps }: PropsWithChildren<CardProps>) {
  return (
    <OptionCardContainer {...restProps}>
      <Flex flexDirection='column-reverse' height={160} width='100%' position='relative'>
        <Thumbnail src={image} loading='lazy' />
        <HashTagContainer flexDirection='row' position='absolute' gap={8}>
          {hashTags.map((hashTag, idx) => (
            <HashTag key={idx} title={hashTag} />
          ))}
        </HashTagContainer>
        {containsHmgData && <HMGTag css={HMGTagPosition} />}
      </Flex>
      {children}
    </OptionCardContainer>
  );
}

interface ExtraProps extends HTMLAttributes<HTMLDivElement> {
  info: ExtraOptionResponse;
  isChecked?: boolean;
  addOption?: (idx: SelectionInfoWithImage) => void;
  removeOption?: (idx: SelectionInfoWithImage) => void;
}

function ExtraOptionCard({ info, isChecked, addOption, removeOption, ...restProps }: ExtraProps) {
  const [isActive, setIsActive] = useState(isChecked);

  const handleClickIcon: MouseEventHandler<HTMLButtonElement> = () => {
    setIsActive((prev) => !prev);
    const { id, name, price, image } = info;
    isActive
      ? removeOption && removeOption({ id: id, name: name, price: price, image: image })
      : addOption && addOption({ id: id, name: name, price: price, image: image });
  };

  useEffect(() => {
    setIsActive(isChecked);
  }, [isChecked]);

  return (
    <OptionCard image={info.image} hashTags={info.hashTags} containsHmgData={info.containsHmgData} {...restProps}>
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
        <CheckBox isActive={isActive ?? false} css={IconPosition} onClick={handleClickIcon} />
      </MainContainer>
    </OptionCard>
  );
}

interface DefaultProps extends HTMLAttributes<HTMLDivElement> {
  info: DefaultOptionResponse;
}

function DefaultOptionCard({ info, ...restProps }: DefaultProps) {
  return (
    <OptionCard image={info.image} hashTags={info.hashTags} containsHmgData={info.containsHmgData} {...restProps}>
      <MainContainer>
        <Typography color='gray900' font='HeadKRMedium16'>
          {info.name}
        </Typography>
        <Typography color='gray500' font='TextKRMedium14'>
          기본 옵션
        </Typography>
      </MainContainer>
    </OptionCard>
  );
}

OptionCard.Extra = ExtraOptionCard;
OptionCard.Default = DefaultOptionCard;

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

const Thumbnail = styled.img`
  position: absolute;
  width: 100%;
  height: 100%;
  object-fit: cover;
`;

const HashTagContainer = styled(Flex)`
  padding-bottom: 8px;
  padding-left: 12px;
  z-index: 1;
`;

const HMGTagPosition = css`
  position: absolute;
  top: 0px;
  right: 0px;
  z-index: 1;
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
