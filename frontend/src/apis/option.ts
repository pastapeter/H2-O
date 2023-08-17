import type {
  DefaultOptionResponse,
  ExtraOptionResponse,
  GeneralOptionResponse,
  PackageOptionResponse,
} from '@/types/interface';
import { api } from '@/utils/fetch';

export const getOptionList = async (trimId: number) => {
  const defaultOptionResponse = await api.get<DefaultOptionResponse[]>(`/trim/${trimId}/default-option`);
  const extraOptionResponse = await api.get<ExtraOptionResponse[]>(`/trim/${trimId}/extra-option`);
  const response = { defaultOptionList: defaultOptionResponse, extraOptionList: extraOptionResponse };

  return response;
};

export const getOptionInfo = async (trimId: number, optionId: number) => {
  const response = await api.get<GeneralOptionResponse>(`/trim/${trimId}/option/${optionId}`);

  return response;
};

export const getPackageInfo = async (trimId: number, packageId: number) => {
  const response = await api.get<PackageOptionResponse>(`/trim/${trimId}/package/${packageId}`);

  return response;
};
