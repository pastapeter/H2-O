import type { ComponentProps, MouseEventHandler } from 'react';
import { css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import { getTrimPriceRange } from '@/apis/trim';
import { CTAButton, Flex, Loading, Card as _Card } from '@/components/common';
import { useFetcher, useSafeContext } from '@/hooks';
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

  const { isLoading, refetch } = useFetcher({
    fetchFn: () => getTrimPriceRange(id),
    onSuccess: ({ minPrice, maxPrice }) => {
      dispatch({
        type: 'SET_PRICE_RANGE',
        payload: { minPrice, maxPrice },
      });

      setCurrentSlide(currentSlide + 1);
    },
    enabled: false,
  });

  const handleButtonClick: MouseEventHandler<HTMLButtonElement> = async () => {
    refetch();
  };

  if (isLoading)
    return (
      <Card as='li' {...restProps}>
        <Loading />
      </Card>
    );

  return (
    <Card as='li' {...restProps}>
      <TextContainer flexDirection='column'>
        <p className='description'>{description}</p>
        <h3 className='title'>{title}</h3>
        <span className='price'>{`${toSeparatedNumberFormat(price)} 원`}</span>
      </TextContainer>
      <ButtonContainer>
        <CTAButton
          size='small'
          isFull
          disabled={title !== LE_BLANC}
          css={css`
            ${theme.typography.TextKRMedium12}
          `}
          onClick={handleButtonClick}
        >
          선택하기
        </CTAButton>
      </ButtonContainer>
    </Card>
  );
}

export default TrimCard;

const Card = styled(_Card)`
  flex: 1;
`;

const TextContainer = styled(Flex)`
  padding: 20px 16px 8px 16px;

  .description {
    ${({ theme }) => theme.typography.TextKRRegular12}
    color: ${({ theme }) => theme.colors.gray600};
  }

  .title {
    ${({ theme }) => theme.typography.HeadENMedium20}
  }

  .price {
    ${({ theme }) => theme.typography.HeadKRMedium18}
    margin-top: 8px;
  }
`;

const ButtonContainer = styled.div`
  padding: 0 12px 12px 12px;
`;
