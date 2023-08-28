import { ExteriorColorResponse } from '@/types/response';
import { api } from '@/utils/fetch';

export const getExteriorColors = async (trimId: number) => {
  const response = await api.get<ExteriorColorResponse[]>(`/trim/${trimId}/external-color`);

  return response;
};
