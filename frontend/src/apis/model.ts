import { ModelTypeResponse, TechnicalSpecResponse } from '@/types/interface';
import { api } from '@/utils/fetch';

export const getModelTypes = async (carId: number) => {
  const response = await api.get<ModelTypeResponse>(`/car/${carId}/model-type`);

  return response;
};

export const getTechnicalSpec = async (powertrainId: number, drivetrainId: number) => {
  const response = await api.get<TechnicalSpecResponse>(
    `/technical-spec?powertrainId=${powertrainId}&drivetrainId=${drivetrainId}`,
  );

  return response;
};
