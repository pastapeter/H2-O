import { css } from '@emotion/react';
import styled from '@emotion/styled';
import { Divider, Flex, HMGTag, Typography } from '@/components/common';
import { toSeparatedNumberFormat } from '@/utils/number';

interface BottomHMGDataProps {
  powerTrainType: string;
  driveTrainType: string;
}

interface DataProps {
  title: string;
  value: string;
}

function BottomHMGData({ powerTrainType, driveTrainType }: BottomHMGDataProps) {
  //TODO: API 연동 후 배기량, 평균연비 받아와서 렌더링
  return (
    <Container justifyContent='space-between'>
      <HMGTag
        variant='small'
        css={css`
          position: absolute;
          top: 0;
          left: 46px;
        `}
      />
      <div>
        <Typography font='TextKRRegular14' color='gray900'>
          <Highlight>{powerTrainType}</Highlight>와 <Highlight>{driveTrainType}</Highlight>의
        </Typography>
        <Typography font='TextKRRegular14' color='gray900'>
          배기량과 평균연비입니다.
        </Typography>
      </div>
      <Flex alignItems='center' gap={32} height='fit-content'>
        <Data title='배기량' value={`${toSeparatedNumberFormat(2199)}cc`} />
        <Divider length={41} vertical />
        <Data title='평균연비' value={`${toSeparatedNumberFormat(12)}km/s`} />
      </Flex>
    </Container>
  );
}

function Data({ title, value }: DataProps) {
  return (
    <Flex flexDirection='column' alignItems='center' gap={8}>
      <Typography font='TextKRRegular14' color='gray900'>
        {title}
      </Typography>
      <Typography font='HeadKRRegular26' color='gray900'>
        {value}
      </Typography>
    </Flex>
  );
}

export default BottomHMGData;

const Container = styled(Flex)`
  background-color: ${({ theme }) => theme.colors.blueBg};
  position: relative;
  width: 667px;
  height: 100%;
  padding: 25px 70px 0 46px;
`;

const Highlight = styled.span`
  ${({ theme }) => theme.typography.TextKRMedium16}
  color: ${({ theme }) => theme.colors.activeBlue};
`;
