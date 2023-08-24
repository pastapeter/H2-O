import { QuotationBody, QutationResponse, SalesCountResponse } from '@/types/response';
import { api } from '@/utils/fetch';

export const postSimilarOption = async (body: QuotationBody) => {
  const response = await api.post<QuotationBody, QutationResponse[]>('/quotation/similar', body);

  return response;
};

export const postSalesCount = async (body: QuotationBody) => {
  const response = await api.post<QuotationBody, SalesCountResponse>('/quotation/sales', body);

  return response;
};
