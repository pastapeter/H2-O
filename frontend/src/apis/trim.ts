import { TrimResponse } from '@/types/interface';
import { api } from '@/utils/fetch';

export const getTrims = async (carId: number) => {
  const response = await api.get<TrimResponse[]>(`/car/${carId}/trim`);

  return response;
};
