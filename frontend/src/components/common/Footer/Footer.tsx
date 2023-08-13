import type { PropsWithChildren } from 'react';
import styled from '@emotion/styled';
import { CTAButton, Flex, PriceSummaryButton, SummaryPopup, Typography } from '@/components/common';
import { useSafeContext, useToggle } from '@/hooks';
import { toSeparatedNumberFormat } from '@/utils/number';
import { SelectionContext } from '@/providers/SelectionProvider';
import { SlideContext } from '@/providers/SlideProvider';

function Footer({ children }: PropsWithChildren) {
  const { totalPrice } = useSafeContext(SelectionContext);
  const { setCurrentSlide } = useSafeContext(SlideContext);
  const { status: isPopupOpen, setOff: handleClosePopup, setOn: handleOpenPopup } = useToggle(false);

  const handleClickNext = () => {
    setCurrentSlide((prev) => prev + 1);
  };

  return (
    <FooterContainer as='footer' justifyContent='flex-end' height={120} width='100%'>
      <ContentContainer justifyContent={children ? 'space-between' : 'flex-end'}>
        {children}
        <Flex flexDirection='column' alignItems='flex-end' width='fit-content'>
          <Flex justifyContent='space-between' alignItems='center' width='100%' marginBottom={6} gap={20}>
            <PriceSummaryButton onClick={handleOpenPopup}>견적요약</PriceSummaryButton>
            <Flex alignItems='center' gap={8}>
              <Typography font='TextKRRegular12' color='gray700'>
                현재 총 가격
              </Typography>
              <Typography font='HeadKRMedium24' color='primary500'>{`${toSeparatedNumberFormat(
                totalPrice,
              )} 원`}</Typography>
            </Flex>
          </Flex>
          <CTAButton onClick={handleClickNext}>다음</CTAButton>
        </Flex>
      </ContentContainer>
      {isPopupOpen && <SummaryPopup handleClickCloseButton={handleClosePopup} />}
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
