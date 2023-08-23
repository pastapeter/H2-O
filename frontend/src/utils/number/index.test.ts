import { setPriceFormat, toSeparatedNumberFormat } from '@/utils/number';

describe('toSeparateNumberFormat 유틸 함수 테스트', () => {
  it('숫자를 3자리마다 콤마(,)를 찍어서 반환한다.', () => {
    const number = 135135;
    const result = toSeparatedNumberFormat(number);

    expect(result).toBe('135,135');
  });
});

describe('setPriceFormat 유틸함수 테스트', () => {
  it('setPriceFormat이 값을 반환한다.', () => {
    const input = 100000;
    const result = setPriceFormat(input);

    expect(result).toBeTruthy();
  });

  it('input과 unit을 입력하면 input을 unit으로 나눈값을 반환한다.', () => {
    const input = 100000;
    const unit = 10000;

    const result = setPriceFormat(input, unit);
    expect(result).toBe(10);
  });

  it('나눈 값이 소수면 반올림을 하여 반환한다.', () => {
    const input = 100000;
    let unit = 10001;

    let result = setPriceFormat(input, unit);
    expect(result).toBe(10);

    unit = 3000000;
    result = setPriceFormat(input, unit);
    expect(result).toBe(0);
  });
});
