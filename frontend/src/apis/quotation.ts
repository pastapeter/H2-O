import { QutationBody, QutationResponse, SalesCountResponse } from '@/types/interface';
import { api } from '@/utils/fetch';

export const postSimilarOption = async (body: QutationBody) => {
  const response = await api.post<QutationBody, QutationResponse[]>('/quotation/similar', body);

  return response;
};

export const postSalesCount = async (body: QutationBody) => {
  const response = await api.post<QutationBody, SalesCountResponse>('/quotation/sales', body);

  return response;
};
