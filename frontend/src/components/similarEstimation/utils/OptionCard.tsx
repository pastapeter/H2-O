import { HTMLAttributes } from 'react';
import { useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import type { QuotationOption } from '@/types/interface';
import { Typography, Card as _Card, Icon as _Icon } from '@/components/common';
import { toPriceFormatString } from '@/utils/string';

interface Props extends HTMLAttributes<HTMLDivElement> {
  option: QuotationOption;
  isClicked: boolean;
}

function OptionCard({ option, isClicked, ...restProps }: Props) {
  const { name, price, image } = option;
  const theme = useTheme();
  return (
    <Card isClicked={isClicked} {...restProps}>
      <CardThumbnail src={image} alt='option-thumbnail' />
      <OptionInfoContainer>
        <Typography font='TextKRMedium12'>{name}</Typography>
        <Typography font='TextKRMedium10'>{toPriceFormatString(price)}원</Typography>
        <Icon iconType='Check' size={24} color={isClicked ? theme.colors.activeBlue : theme.colors.gray200} />
      </OptionInfoContainer>
    </Card>
  );
}

export default OptionCard;

const Card = styled(_Card)<{ isClicked: boolean }>`
  ${({ theme }) => theme.flex.flexBetweenCol}
  width: 103px;
  height: 107px;
  border-radius: 2px;
  background-color: ${({ theme, isClicked }) => (isClicked ? theme.colors.cardBg : theme.colors.white)};

  p {
    color: ${({ theme, isClicked }) => (isClicked ? theme.colors.gray900 : theme.colors.gray600)};
  }
`;

const CardThumbnail = styled.img`
  background-color: ${({ theme }) => theme.colors.white};
  width: 101px;
  height: 49px;
  object-fit: cover;
`;

const OptionInfoContainer = styled.div`
  ${({ theme }) => theme.flex.flexBetweenCol}
  flex: 1;
  position: relative;
  padding: 4px 8px;
`;

const Icon = styled(_Icon)`
  position: absolute;
  right: 4px;
  bottom: 4px;
`;
