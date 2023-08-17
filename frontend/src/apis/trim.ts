import type { TrimPriceRangeResponse, TrimResponse } from '@/types/interface';
import { api } from '@/utils/fetch';

export const getTrims = async (carId: number) => {
  const response = await api.get<TrimResponse[]>(`/car/${carId}/trim`);

  return response;
};

export const getTrimPriceRange = async (trimId: number) => {
  const response = await api.get<TrimPriceRangeResponse>(`/trim/${trimId}/price-range`);

  return response;
};
