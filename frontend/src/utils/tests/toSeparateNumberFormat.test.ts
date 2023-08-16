import { toSeparatedNumberFormat } from '@/utils/number';

describe('toSeparateNumberFormat 유틸 함수 테스트', () => {
  it('숫자를 3자리마다 콤마(,)를 찍어서 반환한다.', () => {
    const number = 135135;
    const result = toSeparatedNumberFormat(number);

    expect(result).toBe('135,135');
  });
});
