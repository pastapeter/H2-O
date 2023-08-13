import { Fragment, memo, useEffect, useState } from 'react';
import { css } from '@emotion/react';
import styled from '@emotion/styled';
import type { BodyType, DriveTrain, ModelTypeResponse, PowerTrain } from '@/types/interface';
import { Banner, Footer, PriceStaticBar } from '@/components/common';
import { BottomHMGData, ModelOptionDetail, ModelTypeSelector } from '@/components/model';
import { useSafeContext } from '@/hooks';
import { SelectionContext } from '@/providers/SelectionProvider';

const mocks: ModelTypeResponse = {
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
      image: '/images/disel.png',
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
      image: '/images/disel.png',
    },
  ],
  bodyTypes: [
    {
      id: 1,
      name: '7인승',
      price: 0,
      choiceRatio: 38,
      description: '높은 토크로 파워풀한 드라이빙이 가능하며, 차급대비 연비효율이 우수합니다.',
      image: '/images/disel.png',
    },
    {
      id: 2,
      name: '8인승',
      price: 0,
      choiceRatio: 38,
      description: '높은 토크로 파워풀한 드라이빙이 가능하며, 차급대비 연비효율이 우수합니다.',
      image: '/images/disel.png',
    },
  ],
  driveTrains: [
    {
      id: 1,
      name: '2WD',
      price: 0,
      choiceRatio: 38,
      description: '높은 토크로 파워풀한 드라이빙이 가능하며, 차급대비 연비효율이 우수합니다.',
      image: '/images/disel.png',
    },
    {
      id: 2,
      name: '4WD',
      price: 237000,
      choiceRatio: 38,
      description: '높은 토크로 파워풀한 드라이빙이 가능하며, 차급대비 연비효율이 우수합니다.',
      image: '/images/disel.png',
    },
  ],
};

export type CurrentModel =
  | {
      sort: '파워트레인';
      type: PowerTrain;
    }
  | {
      sort: '바디타입';
      type: BodyType;
    }
  | {
      sort: '구동방식';
      type: DriveTrain;
    };

function ModelPage() {
  const { dispatch } = useSafeContext(SelectionContext);
  const [currentModel, setCurrentModel] = useState<CurrentModel>({ sort: '파워트레인', type: mocks.powerTrains[0] });

  const { sort, type } = currentModel;
  const { name, description, image } = type;
  const isPowerTrainSort = sort === '파워트레인';

  useEffect(() => {
    dispatch({ type: 'SET_POWER_TRAIN', payload: mocks.powerTrains[0] });
    dispatch({ type: 'SET_BODY_TYPE', payload: mocks.bodyTypes[0] });
    dispatch({ type: 'SET_DRIVE_TRAIN', payload: mocks.driveTrains[0] });
  }, []);

  useEffect(() => {
    // TODO: 배기량, 연비정보 데이터 fetching 연결
  }, []);

  const handleSelectModel = (model: CurrentModel) => {
    setCurrentModel(model);
  };

  return (
    <Fragment>
      <Banner title={name} subTitle={sort} description={description}>
        {isPowerTrainSort && (
          <ModelOptionDetail maxOutput={currentModel.type.maxOutput} maxTorque={currentModel.type.maxTorque} />
        )}
        <Image src={image} alt={name} />
      </Banner>
      <ModelTypeSelector
        powerTrains={mocks.powerTrains}
        bodyTypes={mocks.bodyTypes}
        driveTrains={mocks.driveTrains}
        onSelectModel={handleSelectModel}
      />
      <Footer>
        <BottomHMGData powerTrainType={mocks.powerTrains[0].name} driveTrainType={mocks.driveTrains[0].name} />
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

const _ModelPage = memo(ModelPage);
export default _ModelPage;

const Image = styled.img`
  display: block;
  position: absolute;
  right: 0;
  width: 632px;
  height: 100%;
`;
