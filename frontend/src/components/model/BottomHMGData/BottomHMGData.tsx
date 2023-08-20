import { Fragment } from 'react';
import styled from '@emotion/styled';
import type { TechnicalSpecResponse } from '@/types/interface';
import { getTechnicalSpec } from '@/apis/model';
import { Divider, Flex, Typography, HMGTag as _HMGTag, Loading as _Loading } from '@/components/common';
import { useFetcher } from '@/hooks';
import { toSeparatedNumberFormat } from '@/utils/number';
import type { SelectionInfoWithImage } from '@/providers/SelectionProvider';

interface BottomHMGDataProps {
  powerTrain?: SelectionInfoWithImage;
  driveTrain?: SelectionInfoWithImage;
  setTechnicalSpec: (data: TechnicalSpecResponse) => void;
}

interface DataProps {
  title: string;
  value: string;
}

function BottomHMGData({ powerTrain, driveTrain, setTechnicalSpec }: BottomHMGDataProps) {
  const powerTrainId = powerTrain?.id;
  const driveTrainId = driveTrain?.id;

  const { isLoading, data, error } = useFetcher({
    fetchFn: () => getTechnicalSpec(powerTrainId as number, driveTrainId as number),
    enabled: !!powerTrain && !!driveTrain,
    dependency: [powerTrainId, driveTrainId],
    deferTime: 500,
    onSuccess: (data) => {
      setTechnicalSpec(data);
    },
  });

  if (error) return <div>에러 ㅋ</div>;

  return (
    <Container justifyContent='space-between'>
      <HMGTag variant='small' />
      {isLoading ? (
        <Loading />
      ) : (
        data && (
          <Fragment>
            <div>
              <Typography font='TextKRRegular14' color='gray900'>
                <Highlight>{powerTrain?.name}</Highlight>와 <Highlight>{driveTrain?.name}</Highlight>의
              </Typography>
              <Typography font='TextKRRegular14' color='gray900'>
                배기량과 평균연비입니다.
              </Typography>
            </div>
            <Flex alignItems='center' gap={32} height='fit-content'>
              <Data title='배기량' value={`${toSeparatedNumberFormat(data.displacement)}cc`} />
              <Divider length={41} vertical />
              <Data title='평균연비' value={`${toSeparatedNumberFormat(data.fuelEfficiency)}km/L`} />
            </Flex>
          </Fragment>
        )
      )}
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

const HMGTag = styled(_HMGTag)`
  position: absolute;
  top: 0;
  left: 46px;
`;

const Loading = styled(_Loading)`
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
`;
