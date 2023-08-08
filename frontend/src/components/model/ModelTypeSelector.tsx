import styled from '@emotion/styled';
import ModelTypeOptionList from './ModelTypeOptionList';
import { BodyType, DriveTrain, PowerTrain } from '@/types/interface';
import { Flex } from '@/components/common';

interface Props {
  powerTrains: PowerTrain[];
  bodyTypes: BodyType[];
  driveTrains: DriveTrain[];
  selectedPowerTrain: number;
  selectedBodyType: number;
  selectedDriveTrain: number;
  handleClickPowerTrain: (idx: number) => void;
  handleClickBodyType: (idx: number) => void;
  handleClickDriveTrain: (idx: number) => void;
}

function ModelTypeSelector({
  powerTrains,
  bodyTypes,
  driveTrains,
  selectedPowerTrain,
  selectedBodyType,
  selectedDriveTrain,
  handleClickPowerTrain,
  handleClickBodyType,
  handleClickDriveTrain,
}: Props) {
  const powerTrainOptions = makeOptions(powerTrains);
  const bodyTypeOptions = makeOptions(bodyTypes);
  const driveTrainOptions = makeOptions(driveTrains);

  return (
    <Container>
      <div>
        <h2>모델타입을 선택해주세요.</h2>
      </div>
      <Flex gap={16}>
        <ModelTypeOptionList
          name='파워트레인'
          options={powerTrainOptions}
          selectedIdx={selectedPowerTrain}
          onSelect={handleClickPowerTrain}
        />
        <ModelTypeOptionList
          name='바디타입'
          options={bodyTypeOptions}
          selectedIdx={selectedBodyType}
          onSelect={handleClickBodyType}
        />
        <ModelTypeOptionList
          name='구동방식'
          options={driveTrainOptions}
          selectedIdx={selectedDriveTrain}
          onSelect={handleClickDriveTrain}
        />
      </Flex>
    </Container>
  );
}

function makeOptions<T extends PowerTrain | BodyType | DriveTrain>(options: Array<T>) {
  return options.map((option) => ({
    choiceRatio: option.choiceRatio,
    name: option.name,
    price: option.price,
  }));
}

export default ModelTypeSelector;

const Container = styled.div`
  width: 100%;
  min-height: calc(100vh - 420px);
  padding-top: 16px;
  background-color: white;

  & > div {
    max-width: 1024px;
    width: 100%;
    margin: 0 auto;
  }

  h2 {
    ${({ theme }) => theme.typography.HeadKRMedium16}
    margin-bottom: 12px;
  }
`;
