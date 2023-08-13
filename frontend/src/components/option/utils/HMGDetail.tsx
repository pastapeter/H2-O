import styled from '@emotion/styled';
import { Divider, Flex, HMGTag } from '@/components/common';

interface Props {
  overHalf?: boolean;
  choiceCount: number;
  useCount: number;
}

function HMGDetail({ choiceCount, useCount }: Props) {
  return (
    <Flex flexDirection='column' marginTop={12} gap={20}>
      <HMGTag variant='small' />
      <Flex gap={80}>
        <HMGInfoContainer>
          <span className='title'>구매자의 절반이 선택했어요.</span>
          <Divider length={134} color='gray200' />
          <span className='value'>{choiceCount}개</span>
          <span className='unit'>최근 90일 동안</span>
        </HMGInfoContainer>
        <HMGInfoContainer>
          <span className='title'>주행 중 실제로 이만큼 사용해요.</span>
          <Divider length={134} color='gray200' />
          <span className='value'>{useCount}번</span>
          <span className='unit'>1.5만km 당</span>
        </HMGInfoContainer>
        <HMGInfoContainer></HMGInfoContainer>
      </Flex>
    </Flex>
  );
}

export default HMGDetail;

const HMGInfoContainer = styled.div`
  display: flex;
  flex-direction: column;

  .title {
    ${({ theme }) => theme.typography.TextKRMedium12}
    color: ${({ theme }) => theme.colors.gray800};
    padding-bottom: 4px;
  }
  .value {
    ${({ theme }) => theme.typography.HeadKRMedium24}
    color:${({ theme }) => theme.colors.gray900};
    padding-top: 6px;
  }
  .unit {
    ${({ theme }) => theme.typography.TextKRRegular10}
    color:${({ theme }) => theme.colors.gray600}
  }
`;
