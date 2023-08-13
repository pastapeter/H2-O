import styled from '@emotion/styled';
import ModelTypeOptionList from './ModelTypeOptionList';
import { BodyType, DriveTrain, PowerTrain } from '@/types/interface';
import type { CurrentModel } from '@/pages/ModelPage';
import { Flex } from '@/components/common';
import { useSafeContext } from '@/hooks';
import { SelectionContext } from '@/providers/SelectionProvider';

interface Props {
  powerTrains: PowerTrain[];
  bodyTypes: BodyType[];
  driveTrains: DriveTrain[];
  onSelectModel: (model: CurrentModel) => void;
}

function ModelTypeSelector({ powerTrains, bodyTypes, driveTrains, onSelectModel }: Props) {
  const { selectionInfo, dispatch } = useSafeContext(SelectionContext);
  const { powerTrain, bodyType, driveTrain } = selectionInfo;

  const handleSelectPowerTrain = (data: PowerTrain) => {
    const { id, name, price, image } = data;

    dispatch({ type: 'SET_POWER_TRAIN', payload: { id, name, price, image } });
    onSelectModel({ sort: '파워트레인', type: data });
  };

  const handleSelectBodyType = (data: BodyType) => {
    const { id, name, price, image } = data;

    dispatch({ type: 'SET_BODY_TYPE', payload: { id, name, price, image } });
    onSelectModel({ sort: '바디타입', type: data });
  };

  const handleSelectDriveTrain = (data: DriveTrain) => {
    const { id, name, price, image } = data;

    dispatch({ type: 'SET_DRIVE_TRAIN', payload: { id, name, price, image } });
    onSelectModel({ sort: '구동방식', type: data });
  };

  return (
    <Container>
      <div>
        <h2>모델타입을 선택해주세요.</h2>
      </div>
      <Flex gap={16}>
        {powerTrain && (
          <ModelTypeOptionList
            name='파워트레인'
            options={powerTrains}
            selectedId={powerTrain.id}
            onSelect={handleSelectPowerTrain}
          />
        )}
        {bodyType && (
          <ModelTypeOptionList
            name='바디타입'
            options={bodyTypes}
            selectedId={bodyType.id}
            onSelect={handleSelectBodyType}
          />
        )}
        {driveTrain && (
          <ModelTypeOptionList
            name='구동방식'
            options={driveTrains}
            selectedId={driveTrain.id}
            onSelect={handleSelectDriveTrain}
          />
        )}
      </Flex>
    </Container>
  );
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
