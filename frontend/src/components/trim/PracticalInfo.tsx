import { forwardRef } from 'react';
import styled from '@emotion/styled';
import type { TrimOption } from '@/types/interface';
import { HMGTag } from '@/components/common';
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
      <OptionContainer>
        {options.map(({ dataLabel, frequency }) => (
          <Option key={dataLabel}>
            <OptionName>{dataLabel}</OptionName>
            <Divider />
            <Count>{`${Math.round(frequency)}회`}</Count>
            <UnitOfCount>{`${toSeparatedNumberFormat(UNIT_NUMBER)}km 당`}</UnitOfCount>
          </Option>
        ))}
      </OptionContainer>
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
  padding: 0px 16px;
  padding-bottom: 16px;
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

const OptionContainer = styled.div`
  display: flex;
  gap: 52px;
  margin-top: 16px;
`;

const Option = styled.div`
  display: flex;
  flex-direction: column;
  width: 65px;
`;

const OptionName = styled.p`
  ${({ theme }) => theme.typography.TextKRRegular10};
  width: 100%;
  height: 36px;
  word-break: keep-all;
  margin-bottom: 4px;
`;

const Divider = styled.div`
  background-color: ${({ theme }) => theme.colors.gray400};
  width: 100%;
  height: 1px;
`;

const Count = styled.div`
  ${({ theme }) => theme.typography.HeadKRRegular24};
  color: ${({ theme }) => theme.colors.gray900};
  margin-top: 6px;
`;

const UnitOfCount = styled.span`
  ${({ theme }) => theme.typography.TextKRRegular10};
  color: ${({ theme }) => theme.colors.gray600};
`;
