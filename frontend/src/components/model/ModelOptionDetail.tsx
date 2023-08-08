import styled from '@emotion/styled';
import { calculateRatios, getFractionString } from './utils';
import { MaxOutput, MaxTorque } from '@/types/interface';
import { Flex, HMGTag, Typography } from '@/components/common';

interface ModelOptionDetailProps {
  maxOutput: MaxOutput;
  maxTorque: MaxTorque;
}

interface ModelDetailProps {
  label: string;
  value: string;
  ratio: number;
}

function ModelOptionDetail({ maxOutput, maxTorque }: ModelOptionDetailProps) {
  const { outputRatio, torqueRatio } = calculateRatios(maxOutput, maxTorque);

  return (
    <Flex flexDirection='column' gap={16} marginTop={202}>
      <HMGTag variant='small' />
      <Flex alignItems='center' gap={24}>
        <ModelDetail
          label='최고출력(PS/rpm)'
          value={getFractionString({
            denominator: maxOutput.output,
            minRpm: maxOutput.minRpm,
            maxRpm: maxOutput.maxRpm,
          })}
          ratio={outputRatio}
        />
        <Divider />
        <ModelDetail
          label='최대토크(kgf·m/rpm)'
          value={getFractionString({
            denominator: maxTorque.torque,
            minRpm: maxTorque.minRpm,
            maxRpm: maxTorque.maxRpm,
          })}
          ratio={torqueRatio}
        />
      </Flex>
    </Flex>
  );
}

function ModelDetail({ label, value, ratio }: ModelDetailProps) {
  return (
    <Flex flexDirection='column'>
      <Typography font='TextKRMedium10' color='gray600' marginBottom={6}>
        {label}
      </Typography>
      <Typography font='HeadKRRegular26' color='gray900'>
        {value}
      </Typography>
      <PercentBar ratio={ratio} />
    </Flex>
  );
}

export default ModelOptionDetail;

const Divider = styled.div`
  background-color: ${({ theme }) => theme.colors.gray200};
  width: 1px;
  height: 40px;
`;

const PercentBar = styled.div<{ ratio: number }>`
  position: relative;
  background-color: ${({ theme }) => theme.colors.gray200};
  width: 200px;
  height: 4px;

  &::before {
    background-color: ${({ theme }) => theme.colors.activeBlue};
    content: '';
    position: absolute;
    left: 0;
    top: 0;
    height: 100%;
    width: ${({ ratio }) => ratio * 100}%;
  }
`;
