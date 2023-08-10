import { Fragment, memo } from 'react';
import styled from '@emotion/styled';
import { Flex, Typography } from '@/components/common';
import { DetailEstimate, ResultBanner, ResultFooter } from '@/components/result';
import { toSeparatedNumberFormat } from '@/utils/number';

interface InfoProps {
  label: string;
  value: string;
}

function ResultPage() {
  return (
    <Fragment>
      <ResultBanner />
      <SummaryContainer>
        <ContentsWrapper justifyContent='space-between' alignItems='center' height='100%'>
          <Typography font='TextKRMedium14' color='gray900'>
            합리적인 환경으로 완성된
            <br />
            나만의 팰리세이드가 탄생했어요!
          </Typography>
          <Flex gap={50}>
            <Summary label='모델' value='Le Blanc (르블랑)' />
            <Summary label='평균연비' value={`${toSeparatedNumberFormat(2199)}cc`} />
            <Summary label='배기량' value={`${toSeparatedNumberFormat(12)}km/l`} />
          </Flex>
        </ContentsWrapper>
      </SummaryContainer>
      <MainContainer>
        <ContentsWrapper flexDirection='column'>
          <DetailEstimate />
          <ResultFooter />
        </ContentsWrapper>
      </MainContainer>
    </Fragment>
  );
}

function Summary({ label, value }: InfoProps) {
  return (
    <Flex flexDirection='column'>
      <Typography as='span' font='TextKRRegular12' color='gray600'>
        {label}
      </Typography>
      <Typography as='span' font='HeadKRBold26' color='gray900'>
        {value}
      </Typography>
    </Flex>
  );
}

const _ResultPage = memo(ResultPage);
export default _ResultPage;

const ContentsWrapper = styled(Flex)`
  position: relative;
  width: 100%;
  max-width: 1024px;
  height: 100%;
  margin: 0 auto;
`;

const SummaryContainer = styled.div`
  background-color: ${({ theme }) => theme.colors.skyBlueCardBg};
  width: 100%;
  height: 95px;
`;

const MainContainer = styled.div`
  width: 100%;
  height: 100%;
  min-height: 1305px;
  background-color: white;
`;
