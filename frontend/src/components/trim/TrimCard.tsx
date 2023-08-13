import type { ComponentProps, MouseEventHandler } from 'react';
import { css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import { CTAButton, Card } from '@/components/common';
import { useSafeContext } from '@/hooks';
import { toSeparatedNumberFormat } from '@/utils/number';
import { SelectionContext } from '@/providers/SelectionProvider';
import { SlideContext } from '@/providers/SlideProvider';

interface Props extends Omit<ComponentProps<typeof Card>, 'id'> {
  id: number;
  description: string;
  title: string;
  price: number;
}

const LE_BLANC = 'Le Blanc';

function TrimCard({ id, description, title, price, ...restProps }: Props) {
  const { currentSlide, setCurrentSlide } = useSafeContext(SlideContext);
  const { dispatch } = useSafeContext(SelectionContext);
  const theme = useTheme();

  const handleClickButton: MouseEventHandler<HTMLButtonElement> = () => {
    setCurrentSlide(currentSlide + 1);
    dispatch({ type: 'SET_TRIM', payload: { id, name: title, price } });
  };

  return (
    <Card
      css={css`
        flex: 1;
      `}
      {...restProps}
    >
      <TextContainer>
        <Description>{description}</Description>
        <Title>{title}</Title>
        <Price>{`${toSeparatedNumberFormat(price)} 원`}</Price>
      </TextContainer>
      <ButtonContainer>
        <CTAButton
          size='small'
          isFull
          disabled={title !== LE_BLANC}
          css={css`
            ${theme.typography.TextKRMedium12}
          `}
          onClick={handleClickButton}
        >
          선택하기
        </CTAButton>
      </ButtonContainer>
    </Card>
  );
}

export default TrimCard;

const TextContainer = styled.div`
  display: flex;
  flex-direction: column;
  padding: 20px 16px;
  padding-bottom: 8px;
`;

const Description = styled.p`
  ${({ theme }) => theme.typography.TextKRRegular12}
  color: ${({ theme }) => theme.colors.gray600};
`;

const Title = styled.h3`
  ${({ theme }) => theme.typography.HeadENMedium20}
`;

const Price = styled.p`
  ${({ theme }) => theme.typography.HeadKRMedium18}
  margin-top: 8px;
`;

const ButtonContainer = styled.div`
  padding: 0 12px;
  padding-bottom: 12px;
`;
