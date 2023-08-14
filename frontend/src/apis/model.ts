import { ModelTypeResponse } from '@/types/interface';
import { api } from '@/utils/fetch';

export const getModelTypes = async (carId: number) => {
  const response = await api.get<ModelTypeResponse>(`/car/${carId}/model-type`);

  return response;
};
