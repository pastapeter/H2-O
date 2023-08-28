import { Fragment, memo, useState } from 'react';
import styled from '@emotion/styled';
import type { BodyType, DriveTrain, PowerTrain, TechnicalSpecResponse } from '@/types/response';
import { getModelTypes } from '@/apis/model';
import { Banner, Footer, Loading } from '@/components/common';
import { BottomHMGData, ModelOptionDetail, ModelTypeSelector } from '@/components/model';
import { useFetcher, useSafeContext } from '@/hooks';
import { SelectionContext } from '@/providers/SelectionProvider';

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
  const { selectionInfo, dispatch } = useSafeContext(SelectionContext);
  const [currentModel, setCurrentModel] = useState<CurrentModel | null>(null);

  const { isLoading, data: modelTypeData } = useFetcher({
    fetchFn: () => getModelTypes(selectionInfo.model.id),
    onSuccess: (data) => {
      const { powertrains, bodytypes, drivetrains } = data;
      setCurrentModel({ sort: '파워트레인', type: powertrains[0] });

      dispatch({ type: 'SET_POWER_TRAIN', payload: powertrains[0] });
      dispatch({ type: 'SET_BODY_TYPE', payload: bodytypes[0] });
      dispatch({ type: 'SET_DRIVE_TRAIN', payload: drivetrains[0] });
    },
  });

  const handleSelectModel = (model: CurrentModel) => {
    setCurrentModel(model);
  };

  const setTechnicalSpec = ({ displacement, fuelEfficiency }: TechnicalSpecResponse) => {
    dispatch({ type: 'SET_DISPLACEMENT_AND_FUEL_EFFICIENCY', payload: { displacement, fuelEfficiency } });
  };

  if (isLoading || !currentModel) return <Loading />;

  const { sort, type } = currentModel;
  const { name, description, image } = type;
  const isPowerTrainSort = sort === '파워트레인';

  return (
    <Fragment>
      <Banner title={name} subTitle={sort} description={description}>
        {isPowerTrainSort && modelTypeData && (
          <ModelOptionDetail
            powertrains={modelTypeData.powertrains}
            maxOutput={currentModel.type.maxOutput}
            maxTorque={currentModel.type.maxTorque}
          />
        )}
        <Image src={image} alt={name} />
      </Banner>
      {modelTypeData && (
        <ModelTypeSelector
          powerTrains={modelTypeData.powertrains}
          bodyTypes={modelTypeData.bodytypes}
          driveTrains={modelTypeData.drivetrains}
          onSelectModel={handleSelectModel}
        />
      )}
      <Footer>
        <BottomHMGData
          powerTrain={selectionInfo.powerTrain}
          driveTrain={selectionInfo.driveTrain}
          setTechnicalSpec={setTechnicalSpec}
        />
      </Footer>
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
