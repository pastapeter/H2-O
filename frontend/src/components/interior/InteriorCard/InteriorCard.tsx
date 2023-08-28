import type { ComponentProps } from 'react';
import { css } from '@emotion/react';
import styled from '@emotion/styled';
import { Card, Flex, Icon, Typography } from '@/components/common';
import { toPriceFormatString } from '@/utils/string';

interface Props extends ComponentProps<typeof Card> {
  choiceRatio: number;
  name: string;
  price: number;
  image: string;
}

function InteriorCard({ isSelected, choiceRatio, name, price, image, ...restProps }: Props) {
  return (
    <StyledCard isSelected={isSelected} {...restProps}>
      <img src={image} alt={name} width='69px' height='100%' />
      <Content flexDirection='column'>
        <Typography font='TextKRRegular12' color='gray600'>
          <Typography as='span' font='TextKRMedium12' color={isSelected ? 'activeBlue' : 'gray600'}>
            {choiceRatio}%
          </Typography>
          가 선택했어요
        </Typography>
        <Typography as='h3' font='HeadKRMedium14' color={isSelected ? 'gray900' : 'gray500'}>
          {name}
        </Typography>
        <Typography font='TextKRMedium14' color={isSelected ? 'gray900' : 'gray600'} marginTop={24}>
          {toPriceFormatString(price)} 원
        </Typography>
        <Icon
          iconType='Check'
          color={isSelected ? 'activeBlue' : 'gray200'}
          css={css`
            position: absolute;
            bottom: 8px;
            right: 24px;
          `}
        />
      </Content>
    </StyledCard>
  );
}

export default InteriorCard;

const StyledCard = styled(Card)`
  display: flex;
  width: 244.5px;
  height: 110px;
  border-radius: 2px;
`;

const Content = styled(Flex)`
  position: relative;
  flex: 1;
  height: 100%;
  padding: 14px 0px 8px 16px;
  background-color: transparent;
`;
