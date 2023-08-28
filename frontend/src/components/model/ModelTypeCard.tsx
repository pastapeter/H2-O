import type { ComponentProps } from 'react';
import styled from '@emotion/styled';
import { Typography, Card as _Card, Icon as _Icon } from '@/components/common';
import { toPriceFormatString } from '@/utils/string';

export interface Props extends ComponentProps<typeof Card> {
  choiceRatio: number;
  name: string;
  price: number;
}

function ModelTypeCard({ choiceRatio, name, price, isSelected, ...restProps }: Props) {
  return (
    <Card isSelected={isSelected} {...restProps}>
      <Typography font='TextKRRegular12' color='gray700'>
        <Typography as='span' color={isSelected ? 'activeBlue' : 'gray600'}>
          {choiceRatio}%
        </Typography>
        의 선택
      </Typography>
      <Typography font='TextKRMedium16' color={isSelected ? 'gray900' : 'gray600'}>
        {name}
      </Typography>
      <Typography font='TextKRMedium14' color={isSelected ? 'gray900' : 'gray600'}>
        {toPriceFormatString(price)} 원
      </Typography>
      <Icon iconType='Check' color={isSelected ? 'activeBlue' : 'gray200'} />
    </Card>
  );
}

export default ModelTypeCard;

const Card = styled(_Card)`
  position: relative;
  width: 159px;
  height: 76px;
  border-radius: 4px;
  padding: 8px 12px;
  ${({ isSelected }) => !isSelected && 'border-color: white'}
`;

const Icon = styled(_Icon)`
  position: absolute;
  bottom: 8px;
  right: 12px;
`;
