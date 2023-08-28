import { toSeparatedNumberFormat } from '@/utils/number';

interface Params {
  denominator: number;
  minRpm: number;
  maxRpm: number;
}

export const getFractionString = ({ denominator, minRpm, maxRpm }: Params) => {
  const numerator =
    minRpm === maxRpm
      ? toSeparatedNumberFormat(minRpm)
      : `${toSeparatedNumberFormat(minRpm)}-${toSeparatedNumberFormat(maxRpm)}`;
  return `${toSeparatedNumberFormat(denominator)}/${numerator}`;
};
