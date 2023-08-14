import { InteriorColorResponse } from '@/types/interface';
import { api } from '@/utils/fetch';

export const getInteriorColors = async (trimId: number) => {
  const response = await api.get<InteriorColorResponse[]>(`/trim/${trimId}/internal-color`);

  return response;
};
