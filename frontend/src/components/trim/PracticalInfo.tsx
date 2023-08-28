import { forwardRef } from 'react';
import styled from '@emotion/styled';
import type { TrimOption } from '@/types/response';
import { Divider, Flex, HMGTag } from '@/components/common';
import { toSeparatedNumberFormat } from '@/utils/number';

const UNIT_NUMBER = 15000;

interface Props {
  options?: TrimOption[];
}

const PracticalInfo = forwardRef<HTMLDivElement, Props>(({ options = [], ...restProps }, ref) => {
  return (
    <PracticalInfoContainer ref={ref} {...restProps}>
      <HMGTag variant='small' />
      <p>
        해당 트림 포함된 옵션들의 <span>실활용 데이터</span>에요.
      </p>
      <Flex gap={52} marginTop={16}>
        {options.map(({ dataLabel, frequency }) => (
          <Option key={dataLabel} flexDirection='column'>
            <p className='name'>{dataLabel}</p>
            <Divider length='100%' color='gray400' />
            <strong className='count'>{`${Math.round(frequency)}회`}</strong>
            <span className='unit'>{`${toSeparatedNumberFormat(UNIT_NUMBER)}km 당`}</span>
          </Option>
        ))}
      </Flex>
    </PracticalInfoContainer>
  );
});

PracticalInfo.displayName = 'PracticalInfo';
export default PracticalInfo;

const PracticalInfoContainer = styled.div`
  position: relative;
  display: flex;
  flex-direction: column;
  width: fit-content;
  margin-top: 166px;
  padding: 0px 16px 16px 16px;
  transform: translateX(-16px);
  z-index: 15;

  & > p {
    ${({ theme }) => theme.typography.TextKRMedium12}
    margin-top: 12px;

    span {
      color: ${({ theme }) => theme.colors.activeBlue};
    }
  }
`;

const Option = styled(Flex)`
  width: 65px;

  .name {
    ${({ theme }) => theme.typography.TextKRRegular10};
    width: 100%;
    height: 36px;
    word-break: keep-all;
    margin-bottom: 4px;
  }

  .count {
    ${({ theme }) => theme.typography.HeadKRRegular24};
    color: ${({ theme }) => theme.colors.gray900};
    margin-top: 6px;
  }

  .unit {
    ${({ theme }) => theme.typography.TextKRRegular10};
    color: ${({ theme }) => theme.colors.gray600};
  }
`;
