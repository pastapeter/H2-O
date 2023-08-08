import { Fragment, useState } from 'react';
import { css } from '@emotion/react';
import styled from '@emotion/styled';
import { Banner, Footer, PriceStaticBar } from '@/components/common';
import { BottomHMGData, ModelOptionDetail, ModelTypeSelector } from '@/components/model';

const mocks = {
  powerTrains: [
    {
      id: 1,
      name: '디젤 2.2',
      price: 0,
      choiceRatio: 38,
      description: '높은 토크로 파워풀한 드라이빙이 가능하며, 차급대비 연비효율이 우수합니다.',
      maxOutput: {
        output: 202,
        minRpm: 3800,
        maxRpm: 3800,
      },
      maxTorque: {
        torque: 45,
        minRpm: 1750,
        maxRpm: 2750,
      },
      image: '대충 URL',
    },
    {
      id: 2,
      name: '가솔린 3.8',
      price: -2800000,
      choiceRatio: 38,
      description: '높은 토크로 파워풀한 드라이빙이 가능하며, 차급대비 연비효율이 우수합니다.',
      maxOutput: {
        output: 202,
        minRpm: 3800,
        maxRpm: 3800,
      },
      maxTorque: {
        torque: 45,
        minRpm: 1750,
        maxRpm: 2750,
      },
      image: '대충 URL',
    },
  ],
  bodyTypes: [
    {
      id: 1,
      name: '7인승',
      price: 0,
      choiceRatio: 38,
      description: '높은 토크로 파워풀한 드라이빙이 가능하며, 차급대비 연비효율이 우수합니다.',
      image: '대충 URL',
    },
    {
      id: 2,
      name: '8인승',
      price: 0,
      choiceRatio: 38,
      description: '높은 토크로 파워풀한 드라이빙이 가능하며, 차급대비 연비효율이 우수합니다.',
      image: '대충 URL',
    },
  ],
  driveTrains: [
    {
      id: 1,
      name: '2WD',
      price: 0,
      choiceRatio: 38,
      description: '높은 토크로 파워풀한 드라이빙이 가능하며, 차급대비 연비효율이 우수합니다.',
      image: '대충 URL',
    },
    {
      id: 2,
      name: '4WD',
      price: 237000,
      choiceRatio: 38,
      description: '높은 토크로 파워풀한 드라이빙이 가능하며, 차급대비 연비효율이 우수합니다.',
      image: '대충 URL',
    },
  ],
};

type Model = 'powerTrains' | 'bodyTypes' | 'driveTrains';

interface CurrentModel {
  type: Model;
  idx: number;
}

function ModelPage() {
  const [currentModel, setCurrentModel] = useState<CurrentModel>({
    type: 'powerTrains',
    idx: 0,
  });
  const [selectedPowerTrain, setSelectedPowerTrain] = useState(0);
  const [selectedBodyType, setSelectedBodyType] = useState(0);
  const [selectedDriveTrain, setSelectedDriveTrain] = useState(0);

  const currentModelData = mocks[currentModel.type][currentModel.idx];

  const handleClickPowerTrain = (idx: number) => {
    setSelectedPowerTrain(idx);
    setCurrentModel({
      type: 'powerTrains',
      idx,
    });
  };

  const handleClickBodyType = (idx: number) => {
    setSelectedBodyType(idx);
    setCurrentModel({
      type: 'bodyTypes',
      idx,
    });
  };

  const handleClickDriveTrain = (idx: number) => {
    setSelectedDriveTrain(idx);
    setCurrentModel({
      type: 'driveTrains',
      idx,
    });
  };

  return (
    <Fragment>
      <Banner
        title={currentModelData.name}
        subTitle={modelType[currentModel.type]}
        description={currentModelData.description}
      >
        {currentModel.type === 'powerTrains' && (
          <ModelOptionDetail
            maxOutput={mocks.powerTrains[selectedPowerTrain].maxOutput}
            maxTorque={mocks.powerTrains[selectedPowerTrain].maxTorque}
          />
        )}
        <Image src='/images/disel.png' alt='디젤 2.2' />
      </Banner>
      <ModelTypeSelector
        powerTrains={mocks.powerTrains}
        bodyTypes={mocks.bodyTypes}
        driveTrains={mocks.driveTrains}
        selectedPowerTrain={selectedPowerTrain}
        selectedBodyType={selectedBodyType}
        selectedDriveTrain={selectedDriveTrain}
        handleClickPowerTrain={handleClickPowerTrain}
        handleClickBodyType={handleClickBodyType}
        handleClickDriveTrain={handleClickDriveTrain}
      />
      <Footer>
        <BottomHMGData
          powerTrainType={mocks.powerTrains[selectedPowerTrain].name}
          driveTrainType={mocks.driveTrains[selectedDriveTrain].name}
        />
      </Footer>
      <PriceStaticBar
        isComplete={false}
        nowPrice={4100}
        css={css`
          position: fixed;
          top: 16px;
          left: 50%;
          transform: translateX(-50%);
        `}
      />
    </Fragment>
  );
}

const modelType: Record<Model, string> = {
  powerTrains: '파워트레인',
  bodyTypes: '바디타입',
  driveTrains: '구동방식',
};

export default ModelPage;

const Image = styled.img`
  display: block;
  position: absolute;
  right: 0;
  width: 632px;
  height: 100%;
`;
