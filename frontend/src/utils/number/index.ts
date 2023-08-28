export const toSeparatedNumberFormat = (input: number) => {
  return input.toLocaleString('ko-KR');
};

export const setPriceFormat = (input: number, unit = 10000) => {
  return Math.round(input / unit);
};
