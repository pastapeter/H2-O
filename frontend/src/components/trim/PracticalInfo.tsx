import styled from '@emotion/styled';
import { HMGTag } from '@/components/common';
import { toSeparatedNumberFormat } from '@/utils/number';

const UNIT_NUMBER = 15000;

type OptionData = {
  name: string;
  count: number;
};

interface Props {
  options?: OptionData[];
}

function PracticalInfo({ options = [] }: Props) {
  return (
    <PracticalInfoContainer>
      <HMGTag variant='small' />
      <p>
        해당 트림 포함된 옵션들의 <span>실활용 데이터</span>에요.
      </p>
      <div>
        {options.map(({ name, count }) => (
          <Option key={name}>
            <OptionName>{name}</OptionName>
            <Divider />
            <Count>{`${count}회`}</Count>
            <UnitOfCount>{`${toSeparatedNumberFormat(UNIT_NUMBER)}km 당`}</UnitOfCount>
          </Option>
        ))}
      </div>
    </PracticalInfoContainer>
  );
}

export default PracticalInfo;

const PracticalInfoContainer = styled.div`
  display: flex;
  flex-direction: column;
  padding-top: 166px;

  & > p {
    ${({ theme }) => theme.typography.TextKRMedium12}
    margin-top: 12px;

    span {
      color: ${({ theme }) => theme.colors.activeBlue};
    }
  }

  & > div {
    ${({ theme }) => theme.flex.flexDefault}
    gap: 52px;
    margin-top: 16px;
  }
`;

const Option = styled.div`
  display: flex;
  flex-direction: column;
  width: 60px;
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
