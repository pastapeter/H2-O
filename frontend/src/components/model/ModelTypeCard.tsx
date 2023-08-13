import type { ComponentProps } from 'react';
import { css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import { Card, Icon, Typography } from '@/components/common';
import { toPriceFormatString } from '@/utils/string';

export interface Props extends ComponentProps<typeof Card> {
  choiceRatio: number;
  name: string;
  price: number;
}

function ModelTypeCard({ choiceRatio, name, price, isSelected, ...restProps }: Props) {
  const { colors } = useTheme();

  return (
    <StyledCard isSelected={isSelected} {...restProps}>
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
      <Icon
        iconType='Check'
        color={isSelected ? colors.activeBlue : colors.gray200}
        css={css`
          position: absolute;
          bottom: 8px;
          right: 12px;
        `}
      />
    </StyledCard>
  );
}

export default ModelTypeCard;

const StyledCard = styled(Card)`
  position: relative;
  width: 159px;
  height: 76px;
  border-radius: 4px;
  padding: 8px 12px;
  ${({ isSelected }) => !isSelected && 'border-color: white'}
`;
