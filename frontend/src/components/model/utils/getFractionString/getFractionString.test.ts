import { getFractionString } from './getFractionString';

describe('getFractionString 유틸함수 테스트', () => {
  it('getFractionString 함수는 분자값, 최소 rpm, 최대 rpm을 인자로 받아 분수형태의 문자열을 반환한다.', () => {
    const fractionString = getFractionString({
      denominator: 202,
      minRpm: 3800,
      maxRpm: 3800,
    });

    expect(fractionString).toBe('202/3,800');
  });

  it('최소 rpm, 최대 rpm의 값이 일치하면 분모에 하나의 값으로 표시한다.', () => {
    const fractionString = getFractionString({
      denominator: 45,
      minRpm: 1750,
      maxRpm: 1750,
    });

    expect(fractionString).toBe('45/1,750');
  });

  it('최소 rpm, 최대 rpm의 값이 다르면 분모에 "{최소rpm}-{최대rpm}" 형식으로 표시한다.', () => {
    const fractionString = getFractionString({
      denominator: 45,
      minRpm: 1750,
      maxRpm: 2750,
    });

    expect(fractionString).toBe('45/1,750-2,750');
  });
});
