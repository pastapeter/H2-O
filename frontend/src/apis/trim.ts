import { TrimResponse } from '@/types/interface';
import { api } from '@/utils/fetch';

export const getTrims = async (vehicleId: number) => {
  const response = await api.get<TrimResponse[]>(`/vehicle/${vehicleId}/trim`);

  return response;
};
