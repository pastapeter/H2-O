import { toSeparatedNumberFormat } from '@/utils/number';

export const replaceToRealNewLine = (str: string) => {
  return str.replace(/\\n/g, '\n');
};

export const toPriceFormatString = (price: number) => {
  return `${price >= 0 ? '+' : ''}${toSeparatedNumberFormat(price)}`;
};
