import type { TrimPriceDistributionResponse, TrimPriceRangeResponse, TrimResponse } from '@/types/response';
import { api } from '@/utils/fetch';

export const getTrims = async (carId: number) => {
  const response = await api.get<TrimResponse[]>(`/car/${carId}/trim`);

  return response;
};

export const getTrimPriceRange = async (trimId: number) => {
  const response = await api.get<TrimPriceRangeResponse>(`/trim/${trimId}/price-range`);

  return response;
};

export const getTrimPriceDistribution = async (trimId: number) => {
  const response = await api.get<TrimPriceDistributionResponse>(`/trim/${trimId}/price-distribution`);

  return response;
};
