import { InteriorColorResponse } from '@/types/response';
import { api } from '@/utils/fetch';

export const getInteriorColors = async (trimId: number) => {
  const response = await api.get<InteriorColorResponse[]>(`/trim/${trimId}/internal-color`);

  return response;
};
