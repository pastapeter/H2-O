import type { PropsWithChildren } from 'react';
import styled from '@emotion/styled';
import { CTAButton, Flex, PriceSummaryButton, Typography } from '@/components/common';
import { useSafeContext } from '@/hooks';
import { toSeparatedNumberFormat } from '@/utils/number';
import { SlideContext } from '@/providers/SlideProvider';

function Footer({ children }: PropsWithChildren) {
  const { setCurrentSlide } = useSafeContext(SlideContext);

  const handleClickNext = () => {
    setCurrentSlide((prev) => prev + 1);
  };

  return (
    <FooterContainer as='footer' justifyContent='flex-end' height={120} width='100%'>
      <ContentContainer justifyContent={children ? 'space-between' : 'flex-end'}>
        {children}
        <Flex flexDirection='column' alignItems='flex-end' width='fit-content'>
          <Flex justifyContent='space-between' alignItems='center' width='100%' marginBottom={6} gap={20}>
            <PriceSummaryButton>견적요약</PriceSummaryButton>
            <Flex alignItems='center' gap={8}>
              <Typography font='TextKRRegular12' color='gray700'>
                현재 총 가격
              </Typography>
              <Typography font='HeadKRMedium24' color='primary500'>{`${toSeparatedNumberFormat(
                43560000,
              )} 원`}</Typography>
            </Flex>
          </Flex>
          <CTAButton onClick={handleClickNext}>다음</CTAButton>
        </Flex>
      </ContentContainer>
    </FooterContainer>
  );
}

export default Footer;

const FooterContainer = styled(Flex)`
  position: fixed;
  bottom: 0;
`;

const ContentContainer = styled(Flex)`
  width: 1024px;
  margin: 0 auto;
`;
