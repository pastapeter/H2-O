import type { SelectionInfoWithImage } from '@/providers/SelectionProvider';

export const getPriceSum = <T extends SelectionInfoWithImage>(...args: (T | undefined)[]) => {
  return args.reduce((acc, curr) => acc + (curr?.price || 0), 0);
};
