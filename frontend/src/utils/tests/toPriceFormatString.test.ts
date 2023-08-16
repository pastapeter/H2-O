import { toPriceFormatString } from '@/utils/string';

describe('toPriceFormatString 유틸 함수 테스트', () => {
  it('0 이상일 경우 +를 붙여서 반환한다.', () => {
    const price = 1000;
    const result = toPriceFormatString(price);

    expect(result).toBe('+1,000');
  });

  it('음수일 경우 -를 붙여서 반환한다.', () => {
    const price = -1000;
    const result = toPriceFormatString(price);

    expect(result).toBe('-1,000');
  });
});
