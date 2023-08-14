import { ExteriorColorResponse, TechnicalSpecResponse } from '@/types/interface';
import { api } from '@/utils/fetch';

export const getExteriorColors = async (trimId: number) => {
  const response = await api.get<ExteriorColorResponse[]>(`/trim/${trimId}/external-color`);

  return response;
};

export const getTechnicalSpec = async (powertrainId: number, drivetrainId: number) => {
  const response = await api.get<TechnicalSpecResponse>(
    `/technical-spec?powertrainId=${powertrainId}&drivetrainId=${drivetrainId}`,
  );

  return response;
};
