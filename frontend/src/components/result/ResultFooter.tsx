import type { MouseEventHandler } from 'react';
import styled from '@emotion/styled';
import { PageContext } from '@/components/carousel/PageCarousel';
import { CTAButton, Flex, ImageButton, Typography } from '@/components/common';
import { useSafeContext } from '@/hooks';
import { toSeparatedNumberFormat } from '@/utils/number';
import { SelectionContext } from '@/providers/SelectionProvider';

function ResultFooter() {
  const slideRef = useSafeContext(PageContext);
  const { totalPrice } = useSafeContext(SelectionContext);

  const handleClickImageButton: MouseEventHandler<HTMLButtonElement> = () => {
    slideRef.current?.scrollTo({ top: 0, left: 0, behavior: 'smooth' });
  };

  return (
    <Container flexDirection='column' justifyContent='center' alignItems='flex-end' gap={10}>
      <ImageButton onClick={handleClickImageButton}>이미지 확인</ImageButton>
      <Flex alignItems='center' gap={4}>
        <Typography as='span' font='TextKRRegular14' color='gray700'>
          최종 견적 가격
        </Typography>
        <Typography as='strong' font='HeadKRMedium24' color='primary500'>
          {toSeparatedNumberFormat(totalPrice)} 원
        </Typography>
      </Flex>
      <Flex alignItems='center' gap={17} width='100%'>
        <CTAButton isFull disabled>
          공유하기
        </CTAButton>
        <CTAButton isFull disabled>
          PDF 다운로드
        </CTAButton>
        <CTAButton isFull>상담신청</CTAButton>
      </Flex>
    </Container>
  );
}

export default ResultFooter;

const Container = styled(Flex)`
  position: absolute;
  bottom: 0;
  width: 100%;
  padding-bottom: 16px;
`;
