import { calculateRatios } from './calculateRatios';
import { modelType } from '@/mocks/data';

describe('calculateRatios 유틸함수 테스트', () => {
  const { powertrains } = modelType;

  it('calculateRatios 함수는 powertrain 배열과, 출력, 토크를 인자로 받아서 powertrain간의 최대출력의 최댓값 대비 비율과 최대도수의 최댓값 대비 비율을 계산한다.', () => {
    const { outputRatio, torqueRatio } = calculateRatios(
      powertrains,
      powertrains[0].maxOutput,
      powertrains[0].maxTorque,
    );

    expect(outputRatio).toBe(1);
    expect(torqueRatio).toBe(1);
  });
});
