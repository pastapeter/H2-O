import { ComponentProps } from 'react';
import { css, useTheme } from '@emotion/react';
import { Theme } from '@emotion/react/macro';
import styled from '@emotion/styled';
import { Card, Circle, Icon } from '@/components/common';
import { toPriceFormatString } from '@/utils/string';

interface Props extends ComponentProps<typeof Card> {
  colorName: string;
  colorHexCode: string;
  choiceRatio: number;
  price: number;
  isClicked: boolean;
}

function ExteriorCard({ colorName, colorHexCode, choiceRatio, price, isClicked, ...restProps }: Props) {
  const theme = useTheme();

  return (
    <Card css={StyleCard(theme, isClicked)} {...restProps}>
      <Color>
        <Circle type='border' color={isClicked ? theme.colors.primary500 : theme.colors.gray50} className='circle' />
        <Circle type='fill' color={colorHexCode} className='circle' />
      </Color>
      <TextContainer isClicked={isClicked}>
        <div>
          <p className='ratio'>
            <span>{choiceRatio}%</span>가 선택했어요
          </p>
          <p className='name'>{colorName}</p>
        </div>
        <p className='price'>{toPriceFormatString(price)} 원</p>
      </TextContainer>
      <Icon iconType='Check' size={24} color={isClicked ? 'activeBlue' : 'gray200'} css={StyleIcon} />
    </Card>
  );
}

export default ExteriorCard;

const Color = styled.div`
  position: relative;
  margin-left: 4px;
  width: 74px;
  height: 100%;

  .circle {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }
`;

const TextContainer = styled.div<Pick<Props, 'isClicked'>>`
  ${({ theme }) => theme.flex.flexBetweenCol}
  padding: 14px 0px 8px 0px;
  flex: 1;
  height: 100%;

  .ratio {
    ${({ theme }) => theme.typography.TextKRRegular12}
    color: ${({ theme, isClicked }) => (isClicked ? theme.colors.gray700 : theme.colors.gray600)}
  }

  .ratio span {
    ${({ theme }) => theme.typography.TextKRMedium12}
    color: ${({ theme, isClicked }) => (isClicked ? theme.colors.activeBlue : theme.colors.gray600)};
  }

  .name {
    ${({ theme }) => theme.typography.HeadKRMedium14}
    color:${({ theme, isClicked }) => (isClicked ? theme.colors.gray900 : theme.colors.gray500)};
    width: 126px;
  }

  .price {
    ${({ theme }) => theme.typography.TextKRMedium14}
    color: ${({ theme, isClicked }) => (isClicked ? theme.colors.gray900 : theme.colors.gray600)}
  }
`;

const StyleCard = (theme: Theme, isClicked: boolean) => {
  return css`
    ${theme.flex.flexCenterRow}
    position: relative;
    background-color: ${isClicked ? theme.colors.cardBg : theme.colors.white};
    border-radius: 2px;
    border-color: ${isClicked && theme.colors.activeBlue};
    width: 245px;
    height: 110px;

    &:hover {
      background-color: ${!isClicked && theme.colors.hoverBg};
    }
  `;
};

const StyleIcon = css`
  position: absolute;
  top: 78px;
  left: 196px;
`;
